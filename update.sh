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

# ── Load infra/.env para variáveis compartilhadas ────────────
if [ -f infra/.env ]; then
  set -a; source infra/.env; set +a
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
  local envfile="$name/.env"

  echo ""
  echo "==> [$name] verificando imagens..."

  # Garante que o .env existe
  if [ ! -f "$envfile" ]; then
    echo "  AVISO: $envfile não encontrado — usando .env.example como referência"
    echo "  Crie com: cp $name/.env.example $envfile"
    return 1
  fi

  docker compose -f "$file" pull
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
