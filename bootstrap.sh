#!/usr/bin/env bash
# =============================================================
# AslamSys — Mordomo Bootstrap
#
# Deploy order (dependency-based):
#   1. infra          — NATS, Redis, Postgres, Qdrant, Consul, LiteLLM
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

# ── Verificar .env por grupo ──────────────────────────────────
# Cada grupo tem seu próprio .env ao lado do docker-compose.yml
GROUPS_WITH_ENV=(infra iot audio-pipeline financas brain)
missing_env=0
for g in "${GROUPS_WITH_ENV[@]}"; do
  if [ ! -f "$g/.env" ]; then
    echo "  AVISO: $g/.env não encontrado (cp $g/.env.example $g/.env)"
    missing_env=1
  fi
done
if [ "$missing_env" = "1" ]; then
  echo ""
  echo "ERROR: Falaltam arquivos .env. Crie-os antes de continuar."
  exit 1
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
  
  # Inicializa o New-API (Go Gateway) automaticamente
  echo "    seeding new-api configuration..."
  sed "s/TEMP_GROQ_KEY/${GROQ_API_KEY}/g" infra/llm-gateway/setup-gateway.sql | docker exec -i postgres psql -U ${POSTGRES_USER:-aslam} -d ${POSTGRES_DB:-aslam} >/dev/null
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
  deploy_group "brain" "brain/docker-compose.yml"
fi

echo ""
echo "✓ Done. Run 'docker ps' to verify."
