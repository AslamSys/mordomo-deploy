# Bifrost Gateway (infra)

## Container

- Nome: `llm-gateway`
- Imagem: `maximhq/bifrost:v1.3.9-arm64`
- Porta: `8080`
- Arquivo de configuracao: `infra/bifrost/config.json`

## Papel

Gateway OpenAI-compatible centralizado para chat completions e embeddings.

- Chat: `POST /v1/chat/completions`
- Embeddings: `POST /v1/embeddings`

## Providers configurados

- Gemini (chat + embeddings)
- Groq (fallback)

Configuracao atual em `config.json`:

- Gemini: `gemini-2.0-flash`, `gemini-2.5-pro`, `text-embedding-004`
- Groq: `llama-3.3-70b-versatile`

## Variaveis de ambiente (infra/.env)

- `GEMINI_API_KEY`
- `GROQ_API_KEY`
- `BIFROST_API_KEY` (opcional)

## Integracao com o brain

O brain nao envia alias de modelo do gateway. O brain resolve o tier semantico no Redis e envia o modelo real no payload.

Exemplo de request do brain:

```json
{
  "model": "gemini/gemini-2.5-pro",
  "fallbacks": ["groq/llama-3.3-70b-versatile"],
  "messages": [...],
  "tools": [...]
}
```

## Validacao rapida

```bash
docker logs -f llm-gateway
curl -s http://localhost:8080/v1/models | head
```
