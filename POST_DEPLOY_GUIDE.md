# 🚀 Mordomo System - Guia de Pós-Deploy

Este guia contém os passos obrigatórios para configurar sua instância do Mordomo após a conclusão do `bootstrap.sh`.

---

## 1. 👤 Gerenciamento de Identidade (mordomo-people)
O sistema opera em modo de segurança. Por padrão, ele não reconhece nenhum dispositivo ou número de WhatsApp sem mapeamento.

### Como cadastrar o Administrador (Mestre):
Use o script auxiliar fornecido para registrar seu perfil. Sem isso, o Mordomo não responderá às suas mensagens no WhatsApp.

1. Edite o script `scripts/seed_people.py` com seus dados reais (Nome, WhatsApp, etc).
2. Execute o comando:
   ```bash
   python3 scripts/seed_people.py
   ```
> [!TIP]
> Você pode adicionar múltiplos "aliados" alterando o campo `is_owner` para `false` no script para dar acesso limitado a outras pessoas.

---

## 2. 🔑 Chaves de IA e Segredos (Environment)
O sistema utiliza o **Bifrost Gateway** para gerenciar o acesso aos modelos de linguagem de forma centralizada.

1. Abra o arquivo `.env` na raiz do deploy.
2. Certifique-se de preencher:
   - `GEMINI_API_KEY`: Para o modelo principal de resposta (Flash 2.0).
   - `GROQ_API_KEY`: Para classificação de tier e fallback (Llama 3.3).
   - `BIFROST_API_KEY`: A chave mestre que você definiu para o sistema.

3. Reinicie os serviços afetados para aplicar as chaves:
   ```bash
   docker restart llm-gateway mordomo-brain mordomo-openclaw-agent
   ```

---

## 📱 3. Conectando o WhatsApp (OpenClaw)
O Mordomo se conecta ao WhatsApp Web. Você precisará escanear o QR Code uma única vez.

1. Verifique os logs do container OpenClaw para ver o código:
   ```bash
   docker logs -f mordomo-openclaw-agent
   ```
2. Procure pelo QR Code gerado no terminal.
3. Escaneie com o seu WhatsApp (Aparelhos Conectados).
4. Uma vez conectado, a sessão será salva no volume persistente `openclaw-workspace`.

---

## ⚙️ 4. Configurações Adicionais
- **Telegram:** Se desejar usar o Telegram, insira o `TELEGRAM_BOT_TOKEN` no `.env`.
- **IoT:** Certifique-se de que o Broker MQTT está acessível e que os ESP32 estão apontando para o IP do Orange Pi.

---

## ✅ Checklist de Saúde
Para verificar se todos os serviços estão conversando, use o teste de NATS:
```bash
python3 scripts/test_brain.py
```

---
*Manual Gerado pelo Sistema de IA Mordomo*
