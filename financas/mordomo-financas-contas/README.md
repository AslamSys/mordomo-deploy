# 🏦 Finanças — Contas e Saldos

## 🔗 Navegação

**[🏠 AslamSys](https://github.com/AslamSys)** → **[📚 _system](https://github.com/AslamSys/_system)** → **financas-contas**

### Containers Relacionados (finanças)
- [financas-pix](https://github.com/AslamSys/financas-pix)

---

**Container:** `financas-contas`  
**Stack:** Python / Node.js  
**Propósito:** Registro de contas bancárias, consulta de saldos e histórico de transações

---

## 📋 Propósito

Armazena e expõe informações de contas financeiras: saldos, extratos e movimentações. Alimentado manualmente ou via integrações futuras.

---

## 🎯 Responsabilidades

- ✅ Registro de contas (banco, agência, conta, tipo)
- ✅ Consulta de saldo por conta
- ✅ Histórico de transações (entradas e saídas)
- ✅ Resposta a queries do `mordomo-brain` ("quanto tenho no Nubank?")

---

## 🔌 NATS Topics

### Subscribe
```javascript
Topic: "financas.contas.saldo.query"
Payload: {
  "account": "nubank"  // ou "all" para todos
}

Topic: "financas.contas.transacao.add"
Payload: {
  "account": "nubank",
  "amount": -150.00,
  "description": "PIX para João",
  "date": "2026-04-13"
}
```

### Publish
```javascript
Topic: "financas.contas.saldo.response"
Payload: {
  "account": "nubank",
  "balance": 2350.75,
  "updated_at": "2026-04-13T12:00:00Z"
}
```

---

## 🗄️ Armazenamento

```yaml
banco de dados: PostgreSQL (mordomo-postgres)
tabelas:
  - accounts (id, name, bank, type, currency)
  - transactions (id, account_id, amount, description, date, source)
```

---

## 🚀 Docker Compose

```yaml
financas-contas:
  build: ./financas-contas
  environment:
    - NATS_URL=nats://mordomo-nats:4222
    - DATABASE_URL=postgresql://postgres:password@mordomo-postgres:5432/mordomo
  deploy:
    resources:
      limits:
        cpus: '0.3'
        memory: 256M
```
