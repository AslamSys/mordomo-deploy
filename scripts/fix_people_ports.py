import os

file_path = '/home/orangepi/AslamSys/mordomo-deploy/brain/docker-compose.yml'
with open(file_path, 'r') as f:
    content = f.read()

target = 'container_name: mordomo-people'
new_block = 'container_name: mordomo-people\n    ports:\n      - "8000:8000"'

if target in content and '8000:8000' not in content:
    new_content = content.replace(target, new_block)
    with open(file_path, 'w+') as f:
        f.write(new_content)
    print("✅ Docker Compose: Porta 8000 injetada no People.")
else:
    print("ℹ️ Configuração já presente ou alvo não encontrado.")
