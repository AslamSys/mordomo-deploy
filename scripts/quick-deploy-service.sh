#!/usr/bin/env bash
# Deploy rápido no Orange Pi: SCP do código → docker build → recreate container.
# O CI (GitHub → Docker Hub) continua sendo o caminho oficial; use isto para testes.
#
# Uso (na sua máquina, com SSH alias "mordomo"):
#   ./scripts/quick-deploy-service.sh mordomo-audio-capture-vad ../mordomo-audio-capture-vad
#   ./scripts/quick-deploy-service.sh mordomo-wake-word-detector ../mordomo-wake-word-detector
#
# Variáveis opcionais:
#   MORDOMO_HOST=mordomo
#   BUILD_ROOT=~/build
set -euo pipefail

SERVICE="${1:?service name, e.g. mordomo-audio-capture-vad}"
SRC_DIR="${2:?local path to repo root}"
MORDOMO_HOST="${MORDOMO_HOST:-mordomo}"
BUILD_ROOT="${BUILD_ROOT:-~/build}"
IMAGE="renaneunao/${SERVICE}:latest"
COMPOSE_DIR="${COMPOSE_DIR:-~/AslamSys/mordomo-deploy/audio-pipeline}"

echo "==> Release ALSA (arecord) on host..."
ssh -o BatchMode=yes "$MORDOMO_HOST" 'pkill -x arecord 2>/dev/null || true'

echo "==> SCP $SRC_DIR -> $MORDOMO_HOST:$BUILD_ROOT/$SERVICE/"
ssh -o BatchMode=yes "$MORDOMO_HOST" "mkdir -p $BUILD_ROOT/$SERVICE"
scp -o BatchMode=yes -r "$SRC_DIR/Dockerfile" "$SRC_DIR/requirements.txt" "$SRC_DIR/src" \
  "$MORDOMO_HOST:$BUILD_ROOT/$SERVICE/"

echo "==> docker build $IMAGE"
ssh -o BatchMode=yes "$MORDOMO_HOST" "cd $BUILD_ROOT/$SERVICE && docker build -t $IMAGE ."

echo "==> recreate container $SERVICE"
ssh -o BatchMode=yes "$MORDOMO_HOST" \
  "cd $COMPOSE_DIR && docker compose up -d --force-recreate $SERVICE"

echo "==> logs (tail)"
ssh -o BatchMode=yes "$MORDOMO_HOST" "docker logs $SERVICE --tail 15"
