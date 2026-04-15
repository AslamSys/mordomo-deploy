# ­ƒñû OpenClaw Agent - Comunica├º├úo Inteligente + RPA

## ­ƒöù Navega├º├úo

**[­ƒÅá AslamSys](https://github.com/AslamSys)** ÔåÆ **[­ƒôÜ _system](https://github.com/AslamSys/_system)** ÔåÆ **[­ƒôé Aslam (Orange Pi 5 16GB)](https://github.com/AslamSys/_system/blob/main/hardware/mordomo%20-%20(orange-pi-5-16gb)/README.md)** ÔåÆ **mordomo-openclaw-agent**

### Containers Relacionados (aslam)
- [mordomo-audio-bridge](https://github.com/AslamSys/mordomo-audio-bridge)
- [mordomo-audio-capture-vad](https://github.com/AslamSys/mordomo-audio-capture-vad)
- [mordomo-wake-word-detector](https://github.com/AslamSys/mordomo-wake-word-detector)
- [mordomo-speaker-verification](https://github.com/AslamSys/mordomo-speaker-verification)
- [mordomo-whisper-asr](https://github.com/AslamSys/mordomo-whisper-asr)
- [mordomo-speaker-id-diarization](https://github.com/AslamSys/mordomo-speaker-id-diarization)
- [mordomo-source-separation](https://github.com/AslamSys/mordomo-source-separation)
- [mordomo-core-gateway](https://github.com/AslamSys/mordomo-core-gateway)
- [mordomo-orchestrator](https://github.com/AslamSys/mordomo-orchestrator)
- [mordomo-brain](https://github.com/AslamSys/mordomo-brain)
- [mordomo-tts-engine](https://github.com/AslamSys/mordomo-tts-engine)
- [mordomo-system-watchdog](https://github.com/AslamSys/mordomo-system-watchdog)
- [mordomo-dashboard-ui](https://github.com/AslamSys/mordomo-dashboard-ui)

---

**Agente aut├┤nomo** de comunica├º├úo multi-canal e automa├º├úo web, integrado ao ecossistema Mordomo.

---

## ­ƒôï Filosofia: Dois Agentes, Responsabilidades Claras

```
ÔöîÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÉ
Ôöé OpenClaw Agent (Smart Gateway + RPA)           Ôöé
Ôö£ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöñ
Ôöé                                                 Ôöé
Ôöé Responsabilidades:                              Ôöé
Ôöé Ô£à Comunica├º├úo multi-canal (WhatsApp, Telegram) Ôöé
Ôöé Ô£à RPA/Browser tasks simples (scraping, forms)  Ôöé
Ôöé Ô£à Queries diretas respond├¡veis localmente      Ôöé
Ôöé Ô£à IoT direto (controle de dispositivos)        Ôöé
Ôöé                                                 Ôöé
Ôöé LLM Brain: Gemini Flash 2.0 / GPT-4o-mini      Ôöé
Ôöé Decis├úo: "Isso ├® pra mim ou pro Mordomo?"      Ôöé
Ôöé                                                 Ôöé
Ôöé Quando repassa pro Mordomo:                     Ôöé
Ôöé ÔØî Multi-m├│dulo (Seguran├ºa + NAS + Investimentos)Ôöé
Ôöé ÔØî Contexto hist├│rico (RAG conversa├º├úo)         Ôöé
Ôöé ÔØî Automa├º├Áes complexas (triggers + actions)    Ôöé
ÔööÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÿ

ÔöîÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÉ
Ôöé Mordomo Brain (Orchestrator)                   Ôöé
Ôö£ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöñ
Ôöé                                                 Ôöé
Ôöé Responsabilidades:                              Ôöé
Ôöé Ô£à Orquestra├º├úo cross-m├│dulos (IoT, Invest, etc)Ôöé
Ôöé Ô£à RAG + hist├│rico conversacional               Ôöé
Ôöé Ô£à Automa├º├Áes complexas (if-then, schedules)    Ôöé
Ôöé Ô£à Processamento de voz (STT ÔåÆ TTS pipeline)    Ôöé
Ôöé                                                 Ôöé
Ôöé LLM Brain: Claude Sonnet 3.5 / GPT-4o          Ôöé
Ôöé Decis├úo: Qual m├│dulo acionar? Como coordenar?  Ôöé
ÔööÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÿ
```

**Princ├¡pio:** OpenClaw Agent **decide sozinho** se pode resolver ou se precisa escalar para o Mordomo Orchestrator.

---

## ­ƒÅù´©Å Arquitetura Interna (4 m├│dulos, 1 container)

> **Importante:** OpenClaw roda como **1 container Docker** (`openclaw-agent`). Os 4 m├│dulos abaixo s├úo componentes internos do c├│digo-fonte, n├úo containers separados.

```
src/                              # C├│digo-fonte interno do container openclaw-agent
Ôöé
Ôö£ÔöÇ gateway/                       # Multi-channel dispatcher
Ôöé  Ôö£ÔöÇ channels/
Ôöé  Ôöé  Ôö£ÔöÇ whatsapp/               # Baileys (WhatsApp Web)
Ôöé  Ôöé  Ôö£ÔöÇ telegram/               # grammY (Bot API)
Ôöé  Ôöé  Ôö£ÔöÇ discord/                # discord.js
Ôöé  Ôöé  Ôö£ÔöÇ email/                  # IMAP/SMTP
Ôöé  Ôöé  ÔööÔöÇ sms/                    # Twilio
Ôöé  ÔööÔöÇ session-manager/           # Contextos por usu├írio/canal
Ôöé
Ôö£ÔöÇ browser-rpa/                   # Browser automation
Ôöé  Ôö£ÔöÇ chromium/                  # Headless Chrome (spawna on-demand)
Ôöé  Ôö£ÔöÇ cdp-controller/            # Chrome DevTools Protocol
Ôöé  Ôö£ÔöÇ actions/                   # Scraping, forms, screenshots
Ôöé  ÔööÔöÇ ocr-engine/                # Tesseract (quando necess├írio)
Ôöé
Ôö£ÔöÇ skills-hub/                    # MordomoHub registry
Ôöé  Ôö£ÔöÇ local-skills/              # Skills instaladas
Ôöé  Ôö£ÔöÇ remote-mirror/             # ClawHub featured (opcional)
Ôöé  ÔööÔöÇ api/                       # Install, search, execute
Ôöé
ÔööÔöÇ brain-bridge/                  # NATS bridge to Orchestrator
   Ôö£ÔöÇ publisher/                 # Publica quando precisa escalar
   Ôö£ÔöÇ subscriber/                # Subscreve respostas do Mordomo
   ÔööÔöÇ router/                    # Request-reply pattern
```

---

## ­ƒºá OpenClaw Brain: Decis├úo Nativa via LLM

### System Prompt (Exemplo)

```markdown
Voc├¬ ├® o OpenClaw Agent, respons├ível por comunica├º├úo e RPA no sistema Mordomo.

**Suas capacidades:**
- Enviar/receber mensagens: WhatsApp, Telegram, Discord, Email, SMS
- Automa├º├úo web: Abrir p├íginas, extrair dados, preencher formul├írios
- Skills locais: Executar tarefas pre-programadas via MordomoHub

**Quando VOC├è resolve diretamente:**
1. Queries simples respond├¡veis com web scraping
   - Exemplo: "Pre├ºo do caf├® na Amazon"
   - A├º├úo: Browser ÔåÆ amazon.com.br ÔåÆ extrai pre├ºo ÔåÆ responde
   
2. Envios de mensagem diretos
   - Exemplo: "Manda WhatsApp pro Jo├úo dizendo que vou atrasar"
   - A├º├úo: WhatsApp API ÔåÆ envia ÔåÆ confirma
   
3. RPA b├ísico
   - Exemplo: "Me tira print do Dashboard X"
   - A├º├úo: Browser ÔåÆ screenshot ÔåÆ envia imagem
   
4. Controle IoT direto (permiss├úo NATS autorizada)
   - Exemplo: "Abre a porta", "Acende a luz da sala", "Liga o ar"
   - A├º├úo: NATS pub direto ÔåÆ `iot.device.control.*` (sem passar pelo Mordomo)
   - Restri├º├úo: Apenas t├│picos `iot.>` ÔÇö sem acesso a pagamentos, seguran├ºa, sistema

**Quando ESCALAR pro Mordomo Brain:**
1. Multi-m├│dulo (precisar de Seguran├ºa + NAS + Investimentos, etc)
   - Exemplo: "Acende a luz E me avisa quando Bitcoin > $100k"
   - A├º├úo: NATS pub ÔåÆ mordomo.orchestrator.request
   
2. Contexto hist├│rico/RAG
   - Exemplo: "Lembra o que discutimos ontem sobre investimentos?"
   - A├º├úo: NATS pub (Mordomo tem RAG conversacional)
   
3. Automa├º├Áes complexas (triggers, schedules, if-then)
   - Exemplo: "Todo dia ├ás 7h, se temperatura > 25┬░C, liga o ar"
   - A├º├úo: NATS pub (Mordomo coordena IoT + Scheduler)

**Formato de resposta quando escala:**
```json
{
  "decision": "escalate",
  "reason": "multi_module|rag_needed|complex_automation",
  "nats_topic": "mordomo.orchestrator.request",
  "payload": {
    "user_message": "...",
    "context": {...},
    "required_modules": ["iot", "investimentos"]
  }
}
```

**Formato de resposta quando resolve local:**
```json
{
  "decision": "handle_local",
  "action": "browser_scrape|send_message|run_skill",
  "response": "..."
}
```
```

### Exemplo de Decis├úo Real

```typescript
// OpenClaw Brain LLM completion
const userMessage = "Qual o pre├ºo do caf├® na Amazon?";

const completion = await llm.complete({
  system: OPENCLAW_SYSTEM_PROMPT,
  messages: [
    {role: "user", content: userMessage}
  ]
});

// LLM retorna:
{
  decision: "handle_local",
  action: "browser_scrape",
  steps: [
    "navigate to amazon.com.br",
    "search for 'caf├®'",
    "extract first 3 prices",
    "format as list"
  ],
  response_template: "Caf├® na Amazon: {prices}"
}

// OpenClaw executa localmente
const prices = await browserRPA.scrape("amazon.com.br/cafe");
return `Caf├® na Amazon: ${prices.join(', ')}`;
// Lat├¬ncia: ~3s, $0.001 LLM call, sem envolver Mordomo
```

**Caso IoT Direto (sem Mordomo):**

```typescript
const userMessage = "Acende a luz da sala";

const completion = await llm.complete({
  system: OPENCLAW_SYSTEM_PROMPT,
  messages: [{role: "user", content: userMessage}]
});

// LLM retorna:
{
  decision: "handle_local",
  action: "nats_direct",
  iot_topic: "iot.device.control.luz-sala",
  payload: {
    device: "luz",
    room: "sala",
    action: "on",
    source: "openclaw",       // auditoria: identifica quem publicou
    user_id: "whatsapp:+55..."
  }
}

// OpenClaw publica DIRETO no t├│pico IoT (sem passar pelo Mordomo)
const ack = await nats.requestReply(
  "iot.device.control.luz-sala",
  payload,
  {timeout: 3000}
);
return ack.message; // "Luz da sala acesa"
// Lat├¬ncia: ~300ms (sem LLM extra, sem round-trip Mordomo)
```

---

## ­ƒöä Fluxo Completo por Cen├írio

### Cen├írio 1: Query Simples (OpenClaw resolve)

```
User WhatsApp: "Qual o pre├ºo do caf├® na Amazon?"
  Ôåô
ÔöîÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÉ
Ôöé 1. Gateway recebe (Baileys)                      Ôöé
Ôöé    {channel: "whatsapp", from: "+55...",          Ôöé
Ôöé     text: "Qual o pre├ºo do caf├® na Amazon?"}     Ôöé
ÔööÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔö¼ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÿ
                   Ôöé
ÔöîÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔû╝ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÉ
Ôöé 2. OpenClaw Brain (LLM)                           Ôöé
Ôöé    System: [system prompt acima]                  Ôöé
Ôöé    User: "Qual o pre├ºo do caf├® na Amazon?"        Ôöé
Ôöé                                                   Ôöé
Ôöé    ÔùäÔöÇÔöÇ LLM DECISION ÔöÇÔöÇÔû║                           Ôöé
Ôöé    {                                              Ôöé
Ôöé      decision: "handle_local",                    Ôöé
Ôöé      action: "browser_scrape",                    Ôöé
Ôöé      steps: ["navigate amazon", "extract price"], Ôöé
Ôöé      capabilities_check: {                        Ôöé
Ôöé        needs_iot: false,                          Ôöé
Ôöé        needs_history: false,                      Ôöé
Ôöé        needs_multi_module: false                  Ôöé
Ôöé      }                                            Ôöé
Ôöé    }                                              Ôöé
ÔööÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔö¼ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÿ
                   Ôöé Execute local
ÔöîÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔû╝ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÉ
Ôöé 3. Browser RPA Module                             Ôöé
Ôöé    - Spawna Chromium headless                     Ôöé
Ôöé    - Navega amazon.com.br/cafe                    Ôöé
Ôöé    - Selector: .a-price-whole                     Ôöé
Ôöé    - Extrai: "R$ 12,90"                           Ôöé
Ôöé    - Kill browser                                 Ôöé
ÔööÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔö¼ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÿ
                   Ôöé
ÔöîÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔû╝ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÉ
Ôöé 4. Resposta (WhatsApp)                            Ôöé
Ôöé    "Caf├® Pil├úo 500g: R$ 12,90"                    Ôöé
ÔööÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÿ

Lat├¬ncia: ~3.5s (100ms LLM + 3s browser + 400ms network)
Custo: $0.002 (1 LLM call Gemini Flash)
```

**Decis├úo 100% nativa do LLM:** Nenhum regex, nenhum pattern matching. O agente analisa a query e decide que pode resolver localmente via browser.

---

### Cen├írio 2: IoT Direto (OpenClaw age sem Mordomo)

```
User WhatsApp: "Abre a porta pra mim"
  Ôåô
ÔöîÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÉ
Ôöé 1. Gateway recebe (Baileys)                       Ôöé
Ôöé    {channel: "whatsapp", from: "+55...",          Ôöé
Ôöé     text: "Abre a porta pra mim"}                 Ôöé
ÔööÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔö¼ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÿ
                   Ôöé
ÔöîÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔû╝ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÉ
Ôöé 2. OpenClaw Brain (LLM)                           Ôöé
Ôöé    System: [system prompt]                        Ôöé
Ôöé    User: "Abre a porta pra mim"                   Ôöé
Ôöé                                                   Ôöé
Ôöé    ÔùäÔöÇÔöÇ LLM DECISION ÔöÇÔöÇÔû║                           Ôöé
Ôöé    {                                              Ôöé
Ôöé      decision: "handle_local",                    Ôöé
Ôöé      action: "nats_direct",                       Ôöé
Ôöé      iot_topic: "iot.device.control.porta-entrada"Ôöé
Ôöé      capabilities_check: {                        Ôöé
Ôöé        is_iot: TRUE,                              Ôöé
Ôöé        authorized_direct: TRUE,  ÔåÉ NATS perm OK   Ôöé
Ôöé        needs_multi_module: FALSE                  Ôöé
Ôöé      }                                            Ôöé
Ôöé    }                                              Ôöé
ÔööÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔö¼ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÿ
                   Ôöé NATS publish direto (sem Mordomo)
ÔöîÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔû╝ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÉ
Ôöé 3. NATS: iot.device.control.porta-entrada         Ôöé
Ôöé    {                                              Ôöé
Ôöé      action: "open",                              Ôöé
Ôöé      source: "openclaw",    ÔåÉ auditoria           Ôöé
Ôöé      user_id: "whatsapp:+55...",                  Ôöé
Ôöé      reply_to: "openclaw.response.abc123"         Ôöé
Ôöé    }                                              Ôöé
ÔööÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔö¼ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÿ
                   Ôöé
ÔöîÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔû╝ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÉ
Ôöé 4. IoT Orchestrator (Orange Pi 5 Ultra)            Ôöé
Ôöé    - MQTT pub ÔåÆ porta_entrada_esp32               Ôöé
Ôöé    - ESP32: relay ON (abre fechadura)             Ôöé
Ôöé    - MQTT ACK                                     Ôöé
Ôöé    - NATS pub ÔåÆ openclaw.response.abc123          Ôöé
ÔööÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔö¼ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÿ
                   Ôöé
ÔöîÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔû╝ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÉ
Ôöé 5. OpenClaw responde (WhatsApp)                   Ôöé
Ôöé    "Porta aberta! Ô£à"                             Ôöé
ÔööÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÿ

Lat├¬ncia: ~400ms (100ms LLM + 150ms IoT + 150ms reply)
Custo: $0.001 (1 LLM call) ÔÇö Mordomo Brain n├úo foi acionado
```

**OpenClaw resolve sozinho:** Detectou que ├® IoT e tem permiss├úo NATS direta ÔÇö sem intermediar pelo Mordomo. Todo evento fica gravado no JetStream com `source: "openclaw"` para auditoria completa.

---

### Cen├írio 3: RAG Conversacional (OpenClaw escalona)

```
User Discord: "Lembra aquela conversa sobre investimentos de ontem?"
  Ôåô
ÔöîÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔû╝ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÉ
Ôöé OpenClaw Brain (LLM)                              Ôöé
Ôöé    User: "Lembra aquela conversa..."              Ôöé
Ôöé                                                   Ôöé
Ôöé    ÔùäÔöÇÔöÇ LLM DECISION ÔöÇÔöÇÔû║                           Ôöé
Ôöé    {                                              Ôöé
Ôöé      decision: "escalate",                        Ôöé
Ôöé      reason: "rag_needed",                        Ôöé
Ôöé      capabilities_check: {                        Ôöé
Ôöé        needs_iot: false,                          Ôöé
Ôöé        needs_history: TRUE,  ÔåÉ RAG!               Ôöé
Ôöé        can_handle_local: FALSE                    Ôöé
Ôöé      },                                           Ôöé
Ôöé      explanation: "Preciso do hist├│rico de        Ôöé
Ôöé                    conversas armazenado no        Ôöé
Ôöé                    Mordomo RAG (Qdrant)"          Ôöé
Ôöé    }                                              Ôöé
ÔööÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔö¼ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÿ
                   Ôöé NATS pub
ÔöîÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔû╝ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÉ
Ôöé Mordomo Brain ÔåÆ RAG Query                         Ôöé
Ôöé    - Qdrant search: user_id + "investimentos"     Ôöé
Ôöé    - Retorna ├║ltimas 5 conversas                  Ôöé
Ôöé    - LLM sintetiza resposta com contexto          Ôöé
Ôöé    - NATS pub ÔåÆ openclaw.response.xyz             Ôöé
ÔööÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔö¼ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÿ
                   Ôöé
ÔöîÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔû╝ÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÉ
Ôöé OpenClaw responde (Discord)                       Ôöé
Ôöé    "Ontem voc├¬ mencionou investir em ETFs de      Ôöé
Ôöé     S&P 500 e diversificar em renda fixa..."      Ôöé
ÔööÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÇÔöÿ

Lat├¬ncia: ~1.2s (100ms OpenClaw LLM + 400ms Qdrant + 500ms Mordomo LLM + 200ms reply)
```

**Decis├úo nativa:** OpenClaw detecta que precisa de hist├│rico conversacional (RAG), que est├í no Mordomo, ent├úo escalona.

---

## ­ƒôª Recursos e Capacidade

### OpenClaw Agent Container

```yaml
CPU: 30-50% (2-4 threads ativos)
  Ôö£ÔöÇÔöÇ Node.js runtime: 1 thread
  Ôö£ÔöÇÔöÇ Gateway (multi-channel): 1 thread
  Ôö£ÔöÇÔöÇ LLM Brain (Gemini Flash API): network-bound
  Ôö£ÔöÇÔöÇ Browser RPA (quando ativo): 1-2 threads
  ÔööÔöÇÔöÇ NATS client: network-bound

RAM: 1.2GB base + 800MB browser ativo = 2.0GB total
  Ôö£ÔöÇÔöÇ Node.js: 300MB
  Ôö£ÔöÇÔöÇ Gateway channels: 400MB
  Ôö£ÔöÇÔöÇ LLM context cache: 200MB
  Ôö£ÔöÇÔöÇ Session manager: 300MB
  ÔööÔöÇÔöÇ Browser (on-demand): +800MB

Storage: 2.5GB
  Ôö£ÔöÇÔöÇ Code + dependencies: 1.5GB
  Ôö£ÔöÇÔöÇ Browser cache: 500MB
  Ôö£ÔöÇÔöÇ Session states: 300MB
  ÔööÔöÇÔöÇ Skills registry: 200MB

Network:
  Inbound:
    - WhatsApp: WebSocket (Baileys)
    - Telegram: Long Polling / Webhook (grammY)
    - Discord: WebSocket (discord.js)
    - Email: IMAP/SMTP
  Outbound:
    - NATS: nats://nats:4222 (localhost, <5ms)
    - LLM API: Gemini Flash 2.0 / GPT-4o-mini (HTTP)
    - Browser: HTTP/HTTPS (scraping on-demand)

Lat├¬ncia decis├úo LLM: 80-150ms
Lat├¬ncia scraping: 2-5s
Lat├¬ncia NATS round-trip: 200-500ms
```

**Nota:** OpenClaw usa **LLM pr├│prio** (modelo leve e r├ípido). Todas as decis├Áes s├úo 100% nativas do modelo ÔÇö zero regex, zero pattern matching.

---

## ­ƒº® Componentes Detalhados

### 1. Gateway (Multi-Channel Dispatcher)

Recebe mensagens de qualquer canal, normaliza para formato ├║nico e encaminha para o OpenClaw Brain.

```typescript
interface NormalizedMessage {
  id: string;
  channel: "whatsapp" | "telegram" | "discord" | "email" | "sms";
  from: string;           // ID ├║nico do usu├írio
  text: string;
  media?: MediaAttachment;
  timestamp: number;
  session_id: string;
}
```

**Canais suportados:**

| Canal | SDK | Auth | Features |
|-------|-----|------|----------|
| WhatsApp | Baileys | QR Code | Texto, m├¡dia, grupos, rea├º├Áes |
| Telegram | grammY | Bot Token | Texto, m├¡dia, inline keyboards |
| Discord | discord.js | Bot Token | Texto, embeds, threads, slash commands |
| Email | nodemailer + IMAP | SMTP/IMAP | Leitura, envio, filtros |
| SMS | Twilio | API Key | Envio/recebimento b├ísico |

### 2. Browser RPA (Automa├º├úo Web)

Chromium headless on-demand via CDP (Chrome DevTools Protocol).

```yaml
Capacidades:
  - Navega├º├úo: Abre qualquer URL
  - Scraping: Extrai dados via selectors CSS/XPath
  - Screenshots: Captura visual de p├íginas
  - Form filling: Preenche formul├írios automaticamente
  - OCR: Tesseract para imagens (quando necess├írio)

Ciclo de vida:
  1. OpenClaw Brain decide: "preciso do browser"
  2. Spawna inst├óncia Chromium headless
  3. Executa a├º├Áes CDP
  4. Coleta resultado
  5. Kill browser (libera 800MB RAM)
  
Timeout: 30s m├íximo por opera├º├úo
Pool: 1 inst├óncia simult├ónea (limite RAM)
```

### 3. Skills Hub (MordomoHub Registry)

Registry de skills reutiliz├íveis que OpenClaw pode executar.

```
skills-hub/
Ôö£ÔöÇÔöÇ local-skills/           # Skills instaladas no sistema
Ôöé   Ôö£ÔöÇÔöÇ google-search/      # Busca otimizada via API
Ôöé   Ôö£ÔöÇÔöÇ weather/            # Consulta clima (OpenWeatherMap)
Ôöé   Ôö£ÔöÇÔöÇ translator/         # Tradu├º├úo r├ípida
Ôöé   ÔööÔöÇÔöÇ calculator/         # C├ílculos e convers├Áes
Ôöé
Ôö£ÔöÇÔöÇ remote-mirror/          # Skills do ClawHub (opcional)
Ôöé   ÔööÔöÇÔöÇ featured/
Ôöé       Ôö£ÔöÇÔöÇ google-calendar/
Ôöé       Ôö£ÔöÇÔöÇ notion-sync/
Ôöé       ÔööÔöÇÔöÇ smart-home/
Ôöé
ÔööÔöÇÔöÇ api/
    Ôö£ÔöÇÔöÇ registry.ts         # Lista skills dispon├¡veis
    Ôö£ÔöÇÔöÇ install.ts          # Instala nova skill
    ÔööÔöÇÔöÇ execute.ts          # Executa skill
```

O OpenClaw Brain tem acesso ao registry no system prompt ÔÇö ele sabe quais skills existem e quando us├í-las.

### 4. Brain Bridge (NATS Communication)

Ponte de comunica├º├úo bidirecional com o Mordomo Orchestrator via NATS.

```typescript
// Protocolo de mensagem
interface BrainBridgeMessage {
  id: string;                // UUID
  timestamp: number;
  source: "openclaw";
  reply_to: string;          // Topic para resposta
  
  // Contexto do usu├írio
  user_id: string;
  channel: string;
  session_id: string;
  
  // Payload
  intent: string;            // "iot.device.control"
  params: Record<string, any>;
  priority: "emergency" | "interactive" | "background";
  
  // Contexto conversacional (├║ltimas N mensagens)
  conversation_context?: {
    messages: Array<{role: string; content: string}>;
    summary?: string;
  };
}

// NATS Topics
const TOPICS = {
  // OpenClaw ÔåÆ Orchestrator (├║nico canal de entrada para tudo)
  REQUEST: "mordomo.orchestrator.request",

  // Orchestrator ÔåÆ OpenClaw (reply-to)
  RESPONSE: "openclaw.response.{request_id}",

  // Broadcast (Orchestrator ÔåÆ OpenClaw)
  NOTIFICATION: "openclaw.notification",
  ALERT: "openclaw.alert.{priority}",

  // ­ƒÜº N├âO existe mais IoT direto ÔÇö tudo passa pelo Orchestrator por seguran├ºa
};
```

**Request-Reply Pattern:**
```
OpenClaw pub ÔåÆ "mordomo.orchestrator.request" (com reply_to NATS autom├ítico)
Orchestrator sub ÔåÆ resolve person_id ÔåÆ chama brain ÔåÆ despacha actions
Orchestrator pub ÔåÆ reply_to ("Luz da sala acesa" / "Saldo: R$..." / etc.)
OpenClaw recebe ÔåÆ envia texto de volta para o canal do usu├írio
```

---

## ­ƒöÉ Seguran├ºa
### Permiss├Áes NATS (openclaw user)

O OpenClaw se autentica no NATS com um usu├írio dedicado de permiss├Áes limitadas. Editar `nats.conf` para revogar ou expandir:

```conf
authorization {
  users = [
    # ... outros usu├írios ...
    {
      user: "openclaw"
      password: "$2a$11$..."  # bcrypt
      permissions: {
        publish: [
          "mordomo.orchestrator.request"  # Ô£à ├Ünico subject autorizado ÔÇö tudo passa pelo Orchestrator
          # ­ƒÜ½ Sem acesso direto a iot.>, pagamentos.>, seguranca.>, investimentos.>, sistema.>
        ]
        subscribe: [
          "openclaw.>"  # Recebe respostas do orchestrator (reply-to autom├ítico NATS)
        ]
      }
    }
  ]
}
```

**Auditoria:** todo request do OpenClaw inclui `user_id` e `channel`. O Orchestrator resolve o `person_id` via mordomo-people e repassa ao brain/dispatcher. O JetStream ret├®m os eventos por 30 dias.
### Modelo de Confian├ºa (Single-User)

Como Mordomo ├® **single-user dom├®stico**, o modelo de seguran├ºa ├® simplificado:

```yaml
security:
  mode: "single_user"
  dm_pairing: false              # Sem pairing (single-user)
  trust_upstream: true            # Confia em Speaker Verification
  
  # Todos os canais autorizados por padr├úo
  channels:
    whatsapp: {authorized: true}
    telegram: {authorized: true}
    discord:
      authorized: true
      sandbox_public_servers: true  # Sandbox em servers p├║blicos
```

### Sandbox (Discord P├║blico)

Para servidores Discord p├║blicos, browser e comandos system ficam isolados:

```yaml
sandbox:
  discord_public:
    allowed: ["search", "read", "weather", "calculator"]
    denied: ["browser", "system", "iot", "payments"]
```

---

## ­ƒôè M├®tricas Esperadas

```yaml
Volume:
  Mensagens/dia: ~500-2000
  Canais simult├óneos: 3-5

Performance:
  Decis├úo LLM (handle_local vs escalate): 80-150ms
  Resposta local (sem browser): 200-500ms
  Resposta com browser: 2-5s
  Resposta via Mordomo (NATS round-trip): 500ms-2s

Custo LLM:
  Modelo: Gemini Flash 2.0 (gr├ítis tier) ou GPT-4o-mini ($0.15/1M tokens)
  Custo estimado: $5-15/m├¬s (com ~1000 msgs/dia)

Distribui├º├úo esperada:
  handle_local: ~70% (comunica├º├úo + RPA + IoT direto)
  escalate: ~30% (multi-m├│dulo + RAG + automa├º├Áes)

Taxa de erro: <1%
```

---

## ­ƒÜÇ Deployment

### Docker Compose

```yaml
services:
  openclaw-agent:
    image: openclaw/openclaw:latest
    container_name: openclaw-agent
    environment:
      - NODE_ENV=production
      - NATS_URL=nats://nats:4222
      - CONSUL_URL=http://consul:8500
      - LLM_PROVIDER=gemini          # ou openai
      - LLM_MODEL=gemini-2.0-flash   # ou gpt-4o-mini
      - LLM_API_KEY=${LLM_API_KEY}
    volumes:
      - ./config:/app/config
      - ./skills:/app/.openclaw/workspace/skills
      - ./data:/app/data
    ports:
      - "18789:18789"     # WebSocket gateway
    deploy:
      resources:
        limits:
          cpus: '3.0'
          memory: 2.5G
        reservations:
          cpus: '1.0'
          memory: 1.5G
    depends_on:
      - nats
      - consul

  browser-rpa:
    image: browserless/chromium:latest
    container_name: browser-rpa
    environment:
      - MAX_CONCURRENT_SESSIONS=1
      - CONNECTION_TIMEOUT=30000
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 1G
        reservations:
          memory: 256M
```

### Consul Service Registration

```json
{
  "service": {
    "name": "openclaw-agent",
    "tags": ["communication", "rpa", "gateway"],
    "port": 18789,
    "check": {
      "http": "http://localhost:18789/health",
      "interval": "10s"
    },
    "meta": {
      "version": "1.0",
      "channels": "whatsapp,telegram,discord,email,sms",
      "capabilities": "messaging,browser,skills"
    }
  }
}
```

---

## ­ƒôÜ Refer├¬ncias

- [OpenClaw GitHub](https://github.com/anthropics/openclaw)
- [OpenClaw Docs](https://docs.openclaw.ai)
- [NATS Protocol](https://docs.nats.io)
- [Consul Service Discovery](https://www.consul.io/docs)
- [Baileys WhatsApp](https://github.com/WhiskeySockets/Baileys)
- [grammY Telegram](https://grammy.dev)
- [Chrome DevTools Protocol](https://chromedevtools.github.io/devtools-protocol/)

---

## ­ƒöÉ Vault Integration

As credenciais dos canais de comunica├º├úo s├úo obtidas do `mordomo-vault` via `service` auth na inicializa├º├úo. O WhatsApp usa sess├úo QR (n├úo tem token no vault).

```yaml
Credenciais gerenciadas pelo vault:
  - telegram_bot_token    # grammY
  - discord_bot_token     # discord.js
  - twilio_sid            # SMS
  - twilio_token          # SMS
  - smtp_password         # Email

Auth mode: service
M├│dulo token: ${VAULT_MODULE_TOKEN}
```

Veja: [mordomo-vault](https://github.com/AslamSys/mordomo-vault)

