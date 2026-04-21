#!/usr/bin/env bash
# =============================================================
# AslamSys — Mordomo Bootstrap
#
# Deploy order (dependency-based):
#   1. infra          — NATS, Redis, Postgres, Qdrant, Consul, Bifrost
#   2. iot            — mqtt-broker, iot-orchestrator  (needs NATS + Redis)
#   3. audio-pipeline — capture, ASR, TTS, etc.        (needs NATS)
#   4. financas       — contas, pix                    (needs NATS + Postgres)
#   5. brain          — brain, orchestrator, vault,    (needs everything)
#                       people, watchdog, openclaw
#
# Usage:
#   First time:  ./bootstrap.sh
#   Update:      ./bootstrap.sh          (git pull + pull images + recreate changed)
#   Service only: GROUP=brain ./bootstrap.sh
# =============================================================
set -euo pipefail

DEPLOY_DIR="${DEPLOY_DIR:-$(cd "$(dirname "$0")" && pwd)}"

# ── Environment ───────────────────────────────────────────────
if [ -f "brain/.env" ]; then
  # Carrega as variáveis para o shell (ignora comentários e vazias)
  export $(grep -v '^#' brain/.env | xargs)
fi
DEPLOY_REPO="https://github.com/AslamSys/mordomo-deploy.git"

# ── Clone / update repo ───────────────────────────────────────
if [ "$DEPLOY_DIR" = "$(pwd)" ] && [ -d ".git" ]; then
  echo "==> Updating deploy repo..."
  git pull
elif [ ! -d "$DEPLOY_DIR/.git" ]; then
  echo "==> Cloning deploy repo..."
  git clone "$DEPLOY_REPO" "$DEPLOY_DIR"
  cd "$DEPLOY_DIR"
else
  cd "$DEPLOY_DIR"
  git pull
fi

# ── Auto-setup Environment and Secrets ────────────────────────
generate_secret() {
  openssl rand -hex 32
}

for g in infra iot audio-pipeline financas brain; do
  if [ ! -f "$g/.env" ]; then
    echo "  [Auto-Setup] Criando $g/.env a partir do exemplo..."
    cp "$g/.env.example" "$g/.env"
  fi
done

# 1. Generate Infrastructure Secrets
# Postgres Password
if grep -q "POSTGRES_PASSWORD=TROQUE_ISSO" infra/.env; then
  PG_PASS=$(generate_secret)
  sed -i "s|POSTGRES_PASSWORD=TROQUE_ISSO|POSTGRES_PASSWORD=$PG_PASS|g" infra/.env
  sed -i "s|changeme|$PG_PASS|g" brain/.env
  echo "  [Auto-Gen] Senha do Postgres gerada e sincronizada."
fi

# Bifrost API Key (Internal Gateway Token)
if grep -q "^BIFROST_API_KEY=$" infra/.env; then
  B_API_KEY="bf_$(generate_secret)"
  sed -i "s|^BIFROST_API_KEY=$|BIFROST_API_KEY=$B_API_KEY|g" infra/.env
  sed -i "s|^BIFROST_API_KEY=$|BIFROST_API_KEY=$B_API_KEY|g" brain/.env
  echo "  [Auto-Gen] BIFROST_API_KEY gerado e sincronizado."
fi

# 2. Generate Brain/Vault Secrets
if grep -q "^VAULT_MASTER_KEY=$" brain/.env; then
  sed -i "s|^VAULT_MASTER_KEY=$|VAULT_MASTER_KEY=$(generate_secret)|g" brain/.env
  echo "  [Auto-Gen] VAULT_MASTER_KEY gerada."
fi

if grep -q "^PEOPLE_MASTER_KEY=$" brain/.env; then
  sed -i "s|^PEOPLE_MASTER_KEY=$|PEOPLE_MASTER_KEY=$(generate_secret)|g" brain/.env
  echo "  [Auto-Gen] PEOPLE_MASTER_KEY gerada."
fi

if grep -q "^OPENCLAW_GATEWAY_TOKEN=$" brain/.env; then
  sed -i "s|^OPENCLAW_GATEWAY_TOKEN=$|OPENCLAW_GATEWAY_TOKEN=oc_$(generate_secret)|g" brain/.env
  echo "  [Auto-Gen] OPENCLAW_GATEWAY_TOKEN gerado."
fi

# Carrega infra/.env para variáveis usadas no wait_healthy
set -a; source infra/.env; set +a

# ── Docker networks ───────────────────────────────────────────
for net in mordomo-net iot-net; do
  docker network inspect "$net" >/dev/null 2>&1 \
    || docker network create "$net" \
    && echo "  network $net created"
done

# ── Docker Hub login (para pull de imagens privadas) ──────────
if [ -n "${DOCKERHUB_TOKEN:-}" ] && [ -n "${DOCKERHUB_USERNAME:-}" ]; then
  echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin
  echo "  Docker Hub login OK"
elif docker info 2>/dev/null | grep -q "Username"; then
  echo "  Docker Hub already authenticated"
else
  echo "  AVISO: Sem login no Docker Hub (rate limits podem aplicar)"
  echo "  Para autenticar, defina DOCKERHUB_USERNAME e DOCKERHUB_TOKEN"
fi

ensure_iot_mqtt_password_file() {
  local config_dir="$DEPLOY_DIR/iot/mqtt-broker/config"
  local passwd_file="$config_dir/passwd"
  local env_file="$DEPLOY_DIR/iot/.env"

  if [ ! -f "$passwd_file" ]; then
    echo "  INFO: mqtt password file missing, creating $passwd_file"

    if [ ! -f "$env_file" ]; then
      echo "  ERROR: $env_file not found. Create it from iot/.env.example and set MQTT_USER/MQTT_PASSWORD."
      exit 1
    fi

    set -a; source "$env_file"; set +a

    if [ -z "${MQTT_USER:-}" ] || [ -z "${MQTT_PASSWORD:-}" ]; then
      echo "  ERROR: MQTT_USER and MQTT_PASSWORD must be set in iot/.env"
      exit 1
    fi

    if command -v mosquitto_passwd >/dev/null 2>&1; then
      mosquitto_passwd -b -c "$passwd_file" "$MQTT_USER" "$MQTT_PASSWORD"
    elif command -v openssl >/dev/null 2>&1; then
      printf '%s:%s\n' "$MQTT_USER" "$(openssl passwd -6 "$MQTT_PASSWORD")" > "$passwd_file"
    else
      echo "  ERROR: cannot generate MQTT password file; install mosquitto_passwd or openssl"
      exit 1
    fi

    chmod 600 "$passwd_file"
  fi
}

# ── Helper ────────────────────────────────────────────────────
deploy_group() {
  local name="$1"
  local file="$2"
  echo ""
  echo "==> [$name]"
  docker compose -f "$file" pull --quiet
  docker compose -f "$file" up -d --remove-orphans
}

wait_healthy() {
  local container="$1"
  local check_cmd="$2"
  echo "    waiting for $container..."
  until docker exec "$container" $check_cmd >/dev/null 2>&1; do
    sleep 2
  done
  echo "    $container is ready"
}

# ── Deploy ────────────────────────────────────────────────────
GROUP="${GROUP:-all}"

if [[ "$GROUP" == "all" || "$GROUP" == "infra" ]]; then
  deploy_group "infra" "infra/docker-compose.yml"
  wait_healthy "postgres" "pg_isready -U ${POSTGRES_USER:-aslam}"
  wait_healthy "redis"    "redis-cli ping"
  wait_healthy "nats"     "nats-server --help"

  bash infra/redis/seed-brain-tiers.sh redis
fi

if [[ "$GROUP" == "all" || "$GROUP" == "iot" ]]; then
  ensure_iot_mqtt_password_file
  deploy_group "iot" "iot/docker-compose.yml"
fi

if [[ "$GROUP" == "all" || "$GROUP" == "audio-pipeline" ]]; then
  deploy_group "audio-pipeline" "audio-pipeline/docker-compose.yml"
fi

#if [[ "$GROUP" == "all" || "$GROUP" == "financas" ]]; then
#  deploy_group "financas" "financas/docker-compose.yml"
#fi

if [[ "$GROUP" == "all" || "$GROUP" == "brain" ]]; then
  # Ensure the data directory exists and is writable before starting containers
  mkdir -p "brain/mordomo-openclaw-agent"
  chmod -R 777 "brain/mordomo-openclaw-agent"

  # Cleanup residual OpenClaw state before deploy to ensure a "virgin" boot
  # specifically agents/ folder which keeps old provider configs even if openclaw.json changes.
  if [ -d "brain/mordomo-openclaw-agent/agents" ]; then
    echo "  [Cleanup] Removing residual OpenClaw agents state..."
    rm -rf "brain/mordomo-openclaw-agent/agents"
  fi
  deploy_group "brain" "brain/docker-compose.yml"
fi

echo ""
echo "✓ Done. Run 'docker ps' to verify."
