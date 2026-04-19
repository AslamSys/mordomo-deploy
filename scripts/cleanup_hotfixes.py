import os

files = [
    '/home/orangepi/AslamSys/mordomo-deploy/audio-pipeline/docker-compose.yml',
    '/home/orangepi/AslamSys/mordomo-deploy/brain/docker-compose.yml',
    '/home/orangepi/AslamSys/mordomo-deploy/infra/docker-compose.yml'
]

for file_path in files:
    if not os.path.exists(file_path):
        print(f"⏩ Pulando (não existe): {file_path}")
        continue
    with open(file_path, 'r') as f:
        lines = f.readlines()
    
    # Remove as linhas que contêm 'command: /bin/sh -c "pip install'
    new_lines = [l for l in lines if 'pip install' not in l]
    
    if len(new_lines) != len(lines):
        with open(file_path, 'w') as f:
            f.writelines(new_lines)
        print(f"✅ Limpo (Hotfix removido): {file_path}")
    else:
        print(f"ℹ️ Sem hotfix encontrado: {file_path}")
