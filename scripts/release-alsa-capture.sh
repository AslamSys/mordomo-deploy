#!/usr/bin/env bash
# Libera dispositivos ALSA de captura (ex.: arecord esquecido após testes manuais).
# Uso: ./scripts/release-alsa-capture.sh
set -euo pipefail

echo "==> Encerrando processos arecord que seguram o microfone USB..."
pkill -x arecord 2>/dev/null || true
sleep 0.5

if command -v fuser >/dev/null 2>&1; then
  for pcm in /dev/snd/pcm*c; do
    [ -e "$pcm" ] || continue
    if fuser "$pcm" 2>/dev/null | grep -q arecord; then
      echo "  ainda em uso: $pcm"
      fuser -k "$pcm" 2>/dev/null || true
    fi
  done
fi

echo "==> OK — ALSA capture liberado para o container audio-capture-vad."
