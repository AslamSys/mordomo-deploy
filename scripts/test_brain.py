import asyncio
import json
import nats

async def run():
    try:
        nc = await nats.connect("nats://nats:4222")
        payload = {
            "speaker_id": "renan",
            "text": "Qual foi a minha primeira mensagem?",
            "confidence": 1.0
        }
        print("--- Enviando pergunta para o Brain ---")
        resp = await nc.request("mordomo.brain.generate", json.dumps(payload).encode(), timeout=15)
        data = json.loads(resp.data.decode())
        print("\n--- RESPOSTA FINAL DO MORDOMO ---")
        print(f"Texto: {data.get('response_text')}")
        print(f"Modelo: {data.get('model_used')}")
        print(f"Tier: {data.get('tier')}")
        await nc.close()
    except Exception as e:
        print(f"Erro no teste: {e}")

if __name__ == "__main__":
    asyncio.run(run())
