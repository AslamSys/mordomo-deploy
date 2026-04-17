# mordomo-brain (deploy)

## Papel no stack

Servico de raciocinio do ecossistema brain. Consome `mordomo.brain.generate`, usa Groq para classificacao e Bifrost para geracao com tools.

## Dependencias de infraestrutura

- NATS
- Redis db1
- Qdrant
- llm-gateway (Bifrost)

## Variaveis principais (brain/.env)

- `NATS_URL`
- `REDIS_URL`
- `QDRANT_URL`
- `QDRANT_COLLECTION`
- `QDRANT_VECTOR_SIZE`
- `BIFROST_URL`
- `BIFROST_API_KEY`
- `EMBEDDING_MODEL`
- `GROQ_API_KEY`
- `GROQ_MODEL`
- `TIER_FALLBACK`
- `TIER_STRICT_MODE`

## Tiers semanticos

O brain nao faz seed de tiers. O seed e feito pelo deploy infra em Redis db1:

- `mordomo:tiers`
- `mordomo:tiers:fallbacks`

Script de seed:

- `infra/redis/seed-brain-tiers.sh`

Exemplo de verificacao:

```bash
redis-cli -n 1 HGETALL mordomo:tiers
redis-cli -n 1 HGETALL mordomo:tiers:fallbacks
```

## Observacoes operacionais

- Em `TIER_STRICT_MODE=true`, o brain falha startup se tiers nao existirem no Redis.
- Em modo nao estrito, sobe em degradado e tenta novamente no ciclo de cache.
- Fallback final (ultima linha de defesa) e Groq direto sem function calling.
