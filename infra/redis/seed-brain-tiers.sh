#!/usr/bin/env bash
set -euo pipefail

# Seed idempotente do registry de tiers do brain em Redis db1.
# Usa HSETNX para nao sobrescrever configuracoes existentes.

redis_container="${1:-redis}"

simple_model="${TIER_SIMPLE_MODEL:-gemini/gemini-2.0-flash}"
brain_model="${TIER_BRAIN_MODEL:-gemini/gemini-2.5-pro}"
stakes_model="${TIER_STAKES_MODEL:-gemini/gemini-2.5-pro}"

simple_fallback="${TIER_SIMPLE_FALLBACK:-groq/llama-3.3-70b-versatile}"
brain_fallback="${TIER_BRAIN_FALLBACK:-groq/llama-3.3-70b-versatile}"
stakes_fallback="${TIER_STAKES_FALLBACK:-groq/llama-3.3-70b-versatile}"

echo "    seeding brain tiers in Redis db1 (HSETNX)..."

docker exec "$redis_container" redis-cli -n 1 HSETNX mordomo:tiers simple "$simple_model" >/dev/null
docker exec "$redis_container" redis-cli -n 1 HSETNX mordomo:tiers brain "$brain_model" >/dev/null
docker exec "$redis_container" redis-cli -n 1 HSETNX mordomo:tiers stakes "$stakes_model" >/dev/null

docker exec "$redis_container" redis-cli -n 1 HSETNX mordomo:tiers:fallbacks simple "$simple_fallback" >/dev/null
docker exec "$redis_container" redis-cli -n 1 HSETNX mordomo:tiers:fallbacks brain "$brain_fallback" >/dev/null
docker exec "$redis_container" redis-cli -n 1 HSETNX mordomo:tiers:fallbacks stakes "$stakes_fallback" >/dev/null

echo "    tiers seed ok"
