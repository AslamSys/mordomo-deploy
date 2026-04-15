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

# ── Load .env ─────────────────────────────────────────────────
if [ ! -f .env ]; then
  echo "ERROR: .env not found."
  echo "  cp .env.example .env && nano .env"
  exit 1
fi
set -a; source .env; set +a

# ── Docker networks ───────────────────────────────────────────
for net in mordomo-net iot-net; do
  docker network inspect "$net" >/dev/null 2>&1 \
    || docker network create "$net" \
    && echo "  network $net created"
done

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
  until docker exec "$container" sh -c "$check_cmd" >/dev/null 2>&1; do
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
fi

if [[ "$GROUP" == "all" || "$GROUP" == "iot" ]]; then
  deploy_group "iot" "iot/docker-compose.yml"
fi

if [[ "$GROUP" == "all" || "$GROUP" == "audio-pipeline" ]]; then
  deploy_group "audio-pipeline" "audio-pipeline/docker-compose.yml"
fi

if [[ "$GROUP" == "all" || "$GROUP" == "financas" ]]; then
  deploy_group "financas" "financas/docker-compose.yml"
fi

if [[ "$GROUP" == "all" || "$GROUP" == "brain" ]]; then
  deploy_group "brain" "brain/docker-compose.yml"
fi

echo ""
echo "✓ Done. Run 'docker ps' to verify."
