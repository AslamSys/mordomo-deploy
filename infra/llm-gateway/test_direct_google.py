import urllib.request as r
import json
import os

# Pega as chaves do ambiente (Segurança)
KEY_AIZA = os.environ.get("GEMINI_API_KEY_AIZA", "")
KEY_AQ = os.environ.get("GEMINI_API_KEY", "")

def test_google_embedding(key_name, key_value):
    if not key_value:
        print(f"PULANDO {key_name}: Chave não configurada no ambiente.")
        return
        
    print(f"\n--- Testando {key_name} ---")
    
    url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-embedding-001:embedContent?key={key_value}"
    
    data = json.dumps({
        "content": {
            "parts": [{"text": "Teste de funcionamento direto do Windows"}]
        }
    }).encode()

    try:
        req = r.Request(url, data=data, headers={"Content-Type": "application/json"})
        with r.urlopen(req) as resp:
            print(f"Status: {resp.getcode()} OK")
            print("Resultado: Conexão bem sucedida!")
    except Exception as e:
        print(f"Erro: {e}")

if __name__ == "__main__":
    test_google_embedding("Chave Gemini", KEY_AQ)
