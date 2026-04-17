import urllib.request as r
import json
import socket

# Configurações do Teste
GATEWAY_URL = "http://localhost:3000/v1/embeddings" # Rodar de dentro da placa
MASTER_KEY = "mordomo_master_key"

def run_test():
    print("--- INICIANDO TESTE SEGURO DE EMBEDDINGS ---")
    data = json.dumps({
        "model": "text-embedding-3-small",
        "input": "Teste de funcionamento 100% - Mordomo"
    }).encode()

    headers = {
        "Authorization": f"Bearer {MASTER_KEY}",
        "Content-Type": "application/json"
    }

    try:
        req = r.Request(GATEWAY_URL, data=data, headers=headers)
        with r.urlopen(req) as resp:
            print(f"STATUS: {resp.getcode()} OK")
            result = json.loads(resp.read())
            if "data" in result:
                print("SUCESSO: Vetores gerados com sucesso pelo Gateway!")
                print(f"Dimensoes: {len(result['data'][0]['embedding'])}")
            else:
                print("ERRO: Resposta inesperada do Gateway.")
    except Exception as e:
        print(f"FALHA NO TESTE: {e}")

if __name__ == "__main__":
    run_test()
