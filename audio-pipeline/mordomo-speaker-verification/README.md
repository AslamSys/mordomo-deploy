# 🔐 Speaker Verification

## 🔗 Navegação

**[🏠 AslamSys](https://github.com/AslamSys)** → **[📚 _system](https://github.com/AslamSys/_system)** → **[📂 Aslam (Orange Pi 5 16GB)](https://github.com/AslamSys/_system/blob/main/hardware/mordomo%20-%20(orange-pi-5-16gb)/README.md)** → **mordomo-speaker-verification**

### Containers Relacionados (aslam)
- [mordomo-audio-bridge](https://github.com/AslamSys/mordomo-audio-bridge)
- [mordomo-audio-capture-vad](https://github.com/AslamSys/mordomo-audio-capture-vad)
- [mordomo-wake-word-detector](https://github.com/AslamSys/mordomo-wake-word-detector)
- [mordomo-whisper-asr](https://github.com/AslamSys/mordomo-whisper-asr)
- [mordomo-speaker-id-diarization](https://github.com/AslamSys/mordomo-speaker-id-diarization)
- [mordomo-source-separation](https://github.com/AslamSys/mordomo-source-separation)
- [mordomo-orchestrator](https://github.com/AslamSys/mordomo-orchestrator)
- [mordomo-brain](https://github.com/AslamSys/mordomo-brain)
- [mordomo-tts-engine](https://github.com/AslamSys/mordomo-tts-engine)
- [mordomo-system-watchdog](https://github.com/AslamSys/mordomo-system-watchdog)

---

**Container:** `speaker-verification`
**Ecossistema:** Mordomo
**Posição no Fluxo:** Terceiro — autenticação de usuário (GATE de autorização)

---

## 📋 Propósito

Valida se o falante é um usuário autorizado antes de liberar resultados downstream. GATE de autorização: somente após `mordomo.speaker.verified` o orchestrator processa a transcrição e despacha ações.

---

## 🔧 Modelo

**SpeechBrain ECAPA-TDNN** (`speechbrain/spkrec-ecapa-voxceleb`)
- Embedding 192D, EER ~0.87% no VoxCeleb1-O
- Baixado do HuggingFace no primeiro startup e cacheado em `/app/model`

> ⚠️ **Re-enrollment obrigatório após upgrade do Resemblyzer:** embeddings mudaram de 256D (GE2E) → 192D (ECAPA-TDNN). Apague `/data/embeddings/*.npy` e `metadata.json` e re-enroll via `mordomo.speaker.enroll`.

---

## 🐳 Deploy

```yaml
services:
  speaker-verification:
    image: ghcr.io/aslamsys/mordomo-speaker-verification:latest
    restart: unless-stopped
    volumes:
      - ./data/embeddings:/data/embeddings    # embeddings persistidos no host
      - ./data/model:/app/model               # cache do modelo ECAPA-TDNN
    environment:
      - NATS_URL=nats://nats:4222
      - EMBEDDINGS_PATH=/data/embeddings
      - MODEL_SAVEDIR=/app/model/spkrec-ecapa-voxceleb
      - VERIFICATION_THRESHOLD=0.25           # ajuste conforme calibração
      - SETUP_MODE=false                      # true apenas no primeiro boot
```

> **Volume `./data/model`:** monte este volume para evitar que o ECAPA-TDNN (~100MB) seja baixado novamente a cada `docker pull`/restart. Na primeira execução, o container baixa automaticamente do HuggingFace.

---

## ⚙️ Variáveis de Ambiente

| Variável | Padrão | Descrição |
|---|---|---|
| `NATS_URL` | `nats://nats:4222` | URL do NATS |
| `EMBEDDINGS_PATH` | `/data/embeddings` | Diretório de embeddings |
| `MODEL_SAVEDIR` | `/app/model/spkrec-ecapa-voxceleb` | Cache do modelo |
| `VERIFICATION_THRESHOLD` | `0.25` | Threshold de cosine similarity |
| `SETUP_MODE` | `false` | Enrollment aberto (bootstrap) |

---

## 🔌 Interfaces NATS

| Subject | Direção | Descrição |
|---|---|---|
| `mordomo.audio.snippet` | IN | Áudio para verificar |
| `mordomo.speaker.enroll` | IN | Enroll novo speaker (admin only) |
| `mordomo.speaker.enroll.delete` | IN | Remoção de speaker (admin only) |
| `mordomo.speaker.verified` | OUT | Voz verificada — libera pipeline |
| `mordomo.speaker.rejected` | OUT | Voz rejeitada — bloqueia pipeline |
| `mordomo.speaker.enrolled` | OUT | Confirmação de enrollment |

---

## 🔒 Setup Mode (Bootstrap)

1. No primeiro boot, adicione `SETUP_MODE=true` ao docker-compose override
2. Envie `mordomo.speaker.enroll` com `role=admin` para enrolar o admin
3. Reinicie o container **sem** `SETUP_MODE=true`
4. A partir de agora, somente o admin pode enrolar novos speakers
