# Mordomo - Deploy

Repositorio de producao do sistema Mordomo. Este repositorio contem apenas infraestrutura e arquivos de deploy, sem codigo-fonte dos servicos.

## Estrutura

```text
mordomo-deploy/
  bootstrap.sh               # deploy completo por grupos
  update.sh                  # update por grupos
  infra/                     # NATS, Redis, Postgres, Qdrant, Consul, Bifrost
  brain/                     # Brain, Orchestrator, Vault, People, Watchdog, OpenClaw
  iot/                       # MQTT Broker, IoT Orchestrator
  financas/                  # Contas, PIX
  audio-pipeline/            # Capture/VAD, Wake Word, ASR, TTS, Speaker ID, Bridge, LED
```

## Pre-requisitos

- Docker Engine 24+
- Docker Compose v2
- Git

## Deploy inicial

### 1) Clonar o repositorio

```bash
git clone https://github.com/AslamSys/mordomo-deploy.git
cd mordomo-deploy
```

### 2) Criar os arquivos .env por grupo

```bash
cp infra/.env.example infra/.env
cp iot/.env.example iot/.env
cp audio-pipeline/.env.example audio-pipeline/.env
cp financas/.env.example financas/.env
cp brain/.env.example brain/.env
```

### 3) Preencher variaveis obrigatorias

| Grupo | Variaveis obrigatorias |
|---|---|
| infra | POSTGRES_PASSWORD, GEMINI_API_KEY, GROQ_API_KEY |
| iot | MQTT_PASSWORD |
| audio-pipeline | defaults funcionam em desenvolvimento |
| financas | DATABASE_URL |
| brain | VAULT_MASTER_KEY, PEOPLE_MASTER_KEY |

Observacoes:

- O gateway LLM da infraestrutura agora e Bifrost.
- O seed de tiers do brain e responsabilidade do deploy.
- O seed e idempotente (HSETNX), entao nao sobrescreve ajustes manuais existentes.
- O OpenClaw ainda usa a variavel `LITELLM_MASTER_KEY` por compatibilidade; no compose ela recebe o valor de `BIFROST_API_KEY`.

### 4) Rodar bootstrap

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

Ordem de deploy:

1. infra
2. iot
3. audio-pipeline
4. financas
5. brain

## Atualizacao

Atualizar tudo:

```bash
./update.sh
```

Atualizar por grupo:

```bash
./update.sh infra
./update.sh iot
./update.sh audio-pipeline
./update.sh financas
./update.sh brain
```

## Seed de tiers do brain (Redis db1)

Executado automaticamente quando o grupo infra sobe (bootstrap e update):

- Script: infra/redis/seed-brain-tiers.sh
- Chaves: mordomo:tiers e mordomo:tiers:fallbacks

Exemplos operacionais:

```bash
redis-cli -n 1 HGETALL mordomo:tiers
redis-cli -n 1 HGETALL mordomo:tiers:fallbacks

# Alteracao em runtime (sem restart)
redis-cli -n 1 HSET mordomo:tiers simple "gemini/gemini-2.0-flash-exp"
redis-cli -n 1 HSET mordomo:tiers:fallbacks brain "groq/llama-3.3-70b-versatile"
```

## Validacao rapida

```bash
docker ps
docker logs -f llm-gateway
docker logs -f mordomo-brain
redis-cli -n 1 HGETALL mordomo:tiers
```

## Codigo-fonte dos servicos

- https://github.com/AslamSys/mordomo-code
