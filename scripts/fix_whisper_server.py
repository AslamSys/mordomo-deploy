import os

file_path = '/home/orangepi/AslamSys/mordomo-deploy/audio-pipeline/docker-compose.yml'
with open(file_path, 'r') as f:
    content = f.read()

old_line = 'image: renaneunao/mordomo-whisper-asr:latest'
new_line = 'image: renaneunao/mordomo-whisper-asr:latest\n    command: /bin/sh -c "pip install --no-cache-dir requests huggingface-hub && python -m src.main"'

if old_line in content and 'pip install' not in content:
    new_content = content.replace(old_line, new_line)
    with open(file_path, 'w') as f:
        f.write(new_content)
    print("✅ Docker Compose atualizado com Hotfix do Whisper.")
else:
    print("ℹ️ Hotfix já aplicado ou linha não encontrada.")
