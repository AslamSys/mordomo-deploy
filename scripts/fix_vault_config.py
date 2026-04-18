import os

file_path = '/home/orangepi/AslamSys/mordomo-deploy/brain/docker-compose.yml'
with open(file_path, 'r') as f:
    content = f.read()

# 1. Injeta a porta 8200
target = 'container_name: mordomo-vault'
new_port_line = 'container_name: mordomo-vault\n    ports:\n      - "8200:8200"'
if target in content and '8200:8200' not in content:
    content = content.replace(target, new_port_line)

# 2. Injeta o Hotfix de dependências
img_line = 'image: renaneunao/mordomo-vault:latest'
cmd_line = 'image: renaneunao/mordomo-vault:latest\n    command: /bin/sh -c "pip install --no-cache-dir fastapi uvicorn requests && python -m src.main"'
if img_line in content and 'pip install' not in content:
    content = content.replace(img_line, cmd_line)

with open(file_path, 'w') as f:
    f.write(content)
print("✅ Vault: Configuração atualizada no docker-compose do BRAIN.")
