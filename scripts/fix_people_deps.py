import os

file_path = '/home/orangepi/AslamSys/mordomo-deploy/brain/docker-compose.yml'
with open(file_path, 'r') as f:
    content = f.read()

old_line = 'image: renaneunao/mordomo-people:latest'
new_line = 'image: renaneunao/mordomo-people:latest\n    command: /bin/sh -c "pip install --no-cache-dir fastapi uvicorn requests jinja2 python-multipart && python -m src.main"'

if old_line in content and 'pip install' not in content:
    new_content = content.replace(old_line, new_line)
    with open(file_path, 'w') as f:
        f.write(new_content)
    print("✅ Docker Compose: Hotfix de dependências aplicado ao People.")
else:
    print("ℹ️ Hotfix do People já aplicado.")
