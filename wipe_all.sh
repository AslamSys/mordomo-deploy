#!/usr/bin/env bash
# =============================================================
# AslamSys — Mordomo Wipe (RESET DE FÁBRICA)
#
# AVISO: Este script APAGA TUDO:
#   - Bancos de dados (Postgres, Redis, Qdrant, SQLite)
#   - Volumes do Docker
#   - Arquivos .env com suas chaves
#   - Plugins e sessões do OpenClaw
# =============================================================
set -e

echo "⚠️  AVISO: Você está prestes a realizar um RESET DE FÁBRICA no Mordomo."
echo "Todas as chaves, bancos de dados e configurações serão APAGADOS."
echo ""
read -p "Tem certeza que deseja continuar? (y/N): " confirm

if [[ $confirm != [yY] ]]; then
  echo "Wipe cancelado."
  exit 0
fi

echo "==> Parando todos os containers e removendo volumes..."
for g in infra iot audio-pipeline financas brain; do
  if [ -f "$g/docker-compose.yml" ]; then
    echo "    Cleaning $g..."
    docker compose -f "$g/docker-compose.yml" down -v --remove-orphans || true
  fi
done

echo "==> Removendo arquivos de configuração (.env)..."
rm -f infra/.env iot/.env audio-pipeline/.env financas/.env brain/.env

echo "==> Limpando pastas de dados persistentes..."
# Usamos sudo porque os containers criam essas pastas como root
sudo rm -rf brain/mordomo-openclaw-agent/agents
sudo rm -rf brain/mordomo-openclaw-agent/workspace
sudo rm -rf brain/mordomo-openclaw-agent/openclaw.json*

echo "==> Limpando redes do docker..."
sudo docker network rm mordomo-net iot-net 2>/dev/null || true

echo ""
echo "✅ Mordomo Wiped. O sistema está virgem novamente."
echo "Para reinstalar, rode: ./bootstrap.sh"
