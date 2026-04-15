# Mordomo — Deploy

Repositório de produção do sistema **Mordomo**. Contém exclusivamente configurações de deploy — sem código-fonte.

## Estrutura

```
mordomo-deploy/
  bootstrap.sh               ← script de deploy completo
  .env.example               ← template de variáveis de ambiente
  infra/                     ← NATS · Redis · Postgres · Qdrant · Consul · LiteLLM
  brain/                     ← Brain · Orchestrator · Vault · People · Watchdog · OpenClaw
  iot/                       ← MQTT Broker · IoT Orchestrator
  financas/                  ← Contas · PIX
  audio-pipeline/            ← Capture/VAD · Wake Word · ASR · TTS · Speaker ID · Bridge · LED
```

Cada serviço tem seu próprio subdiretório com `README.md`, `.env.example` e arquivos de configuração quando necessário.

---

## Pré-requisitos

- Docker Engine 24+
- Docker Compose v2
- Git

---

## Deploy inicial

### 1. Clonar o repositório

```bash
git clone https://github.com/AslamSys/mordomo-deploy.git
cd mordomo-deploy
```

### 2. Configurar variáveis de ambiente

Cada grupo tem seu próprio `.env.example` ao lado do `docker-compose.yml`. Crie um `.env` para cada um:

```bash
cp infra/.env.example          infra/.env
cp iot/.env.example            iot/.env
cp audio-pipeline/.env.example audio-pipeline/.env
cp financas/.env.example       financas/.env
cp brain/.env.example          brain/.env
```

Edite cada arquivo e preencha os valores obrigatórios:

| Grupo | Variáveis obrigatórias |
|---|---|
| `infra` | `POSTGRES_PASSWORD`, `LITELLM_MASTER_KEY` |
| `iot` | `MQTT_PASSWORD` |
| `audio-pipeline` | — (defaults funcionam para desenvolvimento) |
| `financas` | `DATABASE_URL` (com senha real) |
| `brain` | `VAULT_MASTER_KEY`, `PEOPLE_MASTER_KEY`, `LITELLM_MASTER_KEY` |

### 3. Executar o bootstrap

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

O script executa na seguinte ordem:

| Etapa | Serviços | Aguarda |
|---|---|---|
| 1. infra | NATS, Redis, Postgres, Qdrant, Consul, LiteLLM | Postgres + Redis + NATS healthy |
| 2. iot | MQTT Broker, IoT Orchestrator | — |
| 3. audio-pipeline | Capture/VAD, Wake Word, Whisper ASR, Speaker ID, Source Sep, TTS, Audio Bridge, LED | — |
| 4. financas | Contas, PIX | — |
| 5. brain | Brain, Orchestrator, Vault, People, Watchdog, OpenClaw | — |

### 4. Verificar

```bash
docker ps
```

---

## Atualização

Para atualizar todos os serviços com as imagens mais recentes:

```bash
./bootstrap.sh
```

O script faz `git pull` automaticamente, puxa novas imagens e recria apenas os containers alterados.

Para atualizar um grupo específico:

```bash
GROUP=brain ./bootstrap.sh
GROUP=iot ./bootstrap.sh
GROUP=audio-pipeline ./bootstrap.sh
GROUP=financas ./bootstrap.sh
GROUP=infra ./bootstrap.sh
```

---

## Operações comuns

```bash
# Ver status de todos os containers
docker ps -a

# Logs de um serviço
docker logs -f mordomo-brain

# Reiniciar um serviço
docker compose -f brain/docker-compose.yml restart mordomo-brain

# Parar tudo
docker compose -f brain/docker-compose.yml down
docker compose -f iot/docker-compose.yml down
docker compose -f audio-pipeline/docker-compose.yml down
docker compose -f financas/docker-compose.yml down
docker compose -f infra/docker-compose.yml down
```

---

## Redes Docker

| Rede | Propósito |
|---|---|
| `mordomo-net` | Rede principal — todos os serviços |
| `iot-net` | Rede IoT — MQTT Broker + IoT Orchestrator |

As redes são criadas automaticamente pelo `bootstrap.sh`.

---

## Repositório de código-fonte

[AslamSys/mordomo-code](https://github.com/AslamSys) — contém o código-fonte de cada serviço e os workflows de CI que geram as imagens Docker publicadas no Docker Hub.
