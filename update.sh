#!/usr/bin/env bash
# =============================================================
# AslamSys — Mordomo Update
#
# Puxa novas imagens de todos os serviços (ou de um grupo) e
# recria apenas os containers que tiveram imagem atualizada.
#
# Uso:
#   ./update.sh                  ← atualiza tudo
#   ./update.sh brain            ← atualiza só o brain
#   ./update.sh iot              ← atualiza só o IoT
#   ./update.sh audio-pipeline   ← atualiza só o audio-pipeline
#   ./update.sh financas         ← atualiza só o financas
#   ./update.sh infra            ← atualiza só a infra
# =============================================================
set -euo pipefail

DEPLOY_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DEPLOY_DIR"

# ── Load .env ─────────────────────────────────────────────────
if [ -f .env ]; then
  set -a; source .env; set +a
fi

# ── Grupos disponíveis ────────────────────────────────────────
declare -A GROUPS=(
  [infra]="infra/docker-compose.yml"
  [iot]="iot/docker-compose.yml"
  [audio-pipeline]="audio-pipeline/docker-compose.yml"
  [financas]="financas/docker-compose.yml"
  [brain]="brain/docker-compose.yml"
)

# Ordem de atualização (dependências primeiro)
ORDER=(infra iot audio-pipeline financas brain)

# ── Atualizar repo local ──────────────────────────────────────
echo "==> Atualizando deploy repo..."
git pull --quiet
echo "    ok"

# ── Função de update ─────────────────────────────────────────
update_group() {
  local name="$1"
  local file="${GROUPS[$name]}"

  echo ""
  echo "==> [$name] verificando imagens..."

  # Pull das imagens — docker compose pull exibe o que foi atualizado
  docker compose -f "$file" pull

  # Recria apenas containers com imagem nova (--no-recreate não se aplica;
  # compose só recria se a imagem ou config mudou)
  docker compose -f "$file" up -d --remove-orphans

  echo "    [$name] pronto"
}

# ── Execução ──────────────────────────────────────────────────
TARGET="${1:-all}"

if [ "$TARGET" = "all" ]; then
  for group in "${ORDER[@]}"; do
    update_group "$group"
  done
elif [[ -v GROUPS[$TARGET] ]]; then
  update_group "$TARGET"
else
  echo "ERROR: grupo '$TARGET' desconhecido."
  echo "Grupos disponíveis: ${!GROUPS[*]}"
  exit 1
fi

echo ""
echo "✓ Update concluído."
echo ""
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"
