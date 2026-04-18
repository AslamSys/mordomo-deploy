import asyncio
import json
import nats
import os

async def seed():
    nats_url = os.getenv("NATS_URL", "nats://localhost:4222")
    try:
        nc = await nats.connect(nats_url)
        print(f"Conectado ao NATS: {nats_url}")

        # Configuração do Usuário Mestre (Renan)
        # IMPORTANTE: Altere os valores abaixo ou use variáveis de ambiente
        person_data = {
            "name": "Renan",
            "aliases": ["Chefe", "Mestre", "Admin"],
            "is_owner": True,
            "contacts": [
                {
                    "type": "whatsapp",
                    "value": os.getenv("MY_WHATSAPP", "5511999999999"), # <-- Seu número aqui
                    "label": "Celular Pessoal"
                },
                {
                    "type": "telegram",
                    "value": os.getenv("MY_TELEGRAM", "renan_user"),
                    "label": "Telegram"
                }
            ],
            "permissions": {
                "admin": True,
                "iot_control": True,
                "investimentos_view": True,
                "security_access": "high"
            }
        }

        print(f"Enviando dados de identidade para {person_data['name']}...")
        resp = await nc.request("mordomo.people.upsert", json.dumps(person_data).encode(), timeout=5)
        
        result = json.loads(resp.data.decode())
        if result.get("ok"):
            print(f"✅ Sucesso! Pessoa ID: {result.get('person_id')} mapeada e protegida.")
        else:
            print(f"❌ Erro ao cadastrar: {result.get('error')}")

        await nc.close()
    except Exception as e:
        print(f"❌ Erro de conexão: {e}")

if __name__ == "__main__":
    asyncio.run(seed())
