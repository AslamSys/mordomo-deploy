-- ============================================================
-- AslamSys — PostgreSQL Init Script
-- Executa uma vez no primeiro start (volume vazio)
-- ============================================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================
-- 👤 PEOPLE — Identidade, contatos e permissões
-- Gerenciado por: mordomo-people
-- ============================================================
CREATE SCHEMA IF NOT EXISTS people;

-- Perfis de pessoas reconhecidas pelo Mordomo
CREATE TABLE IF NOT EXISTS people.pessoas (
    id               UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    name             TEXT        NOT NULL,
    aliases          TEXT[]      NOT NULL DEFAULT '{}',  -- nomes alternativos ("João", "Joãozinho")
    voice_profile_id TEXT,                               -- ref: mordomo-speaker-verification
    face_profile_id  TEXT,                               -- ref: seguranca-face-recognition
    is_owner         BOOLEAN     NOT NULL DEFAULT FALSE,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT pessoas_name_unique UNIQUE (lower(name))
);

-- Contatos (chaves PIX, emails, telefones) — value_enc criptografado com AES-256-GCM
CREATE TABLE IF NOT EXISTS people.contatos (
    id         UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id  UUID        NOT NULL REFERENCES people.pessoas(id) ON DELETE CASCADE,
    type       TEXT        NOT NULL,        -- 'pix_key' | 'email' | 'phone'
    value_enc  TEXT        NOT NULL,        -- AES-256-GCM hex(nonce+ciphertext+tag)
    label      TEXT                         -- 'pessoal' | 'trabalho'
);

-- Permissões granulares por pessoa
CREATE TABLE IF NOT EXISTS people.permissoes (
    person_id  UUID        NOT NULL REFERENCES people.pessoas(id) ON DELETE CASCADE,
    key        TEXT        NOT NULL,        -- 'can_authorize_pix' | 'max_pix_amount' | ...
    value      TEXT        NOT NULL,
    PRIMARY KEY (person_id, key)
);

CREATE INDEX IF NOT EXISTS idx_pessoas_aliases ON people.pessoas USING GIN (aliases);
CREATE INDEX IF NOT EXISTS idx_contatos_person ON people.contatos (person_id);

-- ============================================================
-- 🔑 VAULT — Secrets cifrados
-- ============================================================
CREATE SCHEMA IF NOT EXISTS vault;

CREATE TABLE IF NOT EXISTS vault.secrets (
    id         UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    key        TEXT        NOT NULL UNIQUE,
    value_enc  BYTEA       NOT NULL,
    owner_id   UUID        REFERENCES people.pessoas(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 🧠 MORDOMO — Sessões e memória de longo prazo
-- ============================================================
CREATE SCHEMA IF NOT EXISTS mordomo;

CREATE TABLE IF NOT EXISTS mordomo.sessions (
    id         UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id    UUID        REFERENCES people.pessoas(id),
    started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ended_at   TIMESTAMPTZ,
    summary    TEXT
);

CREATE TABLE IF NOT EXISTS mordomo.long_term_memory (
    id           UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id      UUID        REFERENCES people.pessoas(id),
    content      TEXT        NOT NULL,
    source       TEXT,
    embedding_id TEXT,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 💳 FINANÇAS
-- ============================================================
CREATE SCHEMA IF NOT EXISTS financas;

CREATE TABLE IF NOT EXISTS financas.transactions (
    id            UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id       UUID        REFERENCES people.pessoas(id),
    type          TEXT        NOT NULL,
    amount_cents  BIGINT      NOT NULL,
    description   TEXT,
    reference     TEXT,
    status        TEXT        NOT NULL DEFAULT 'pending',
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS financas.accounts (
    id            UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id       UUID        REFERENCES people.pessoas(id),
    bank          TEXT        NOT NULL,
    agency        TEXT,
    account       TEXT,
    balance_cents BIGINT      NOT NULL DEFAULT 0,
    last_synced   TIMESTAMPTZ
);

-- ============================================================
-- 📈 INVESTIMENTOS
-- ============================================================
CREATE SCHEMA IF NOT EXISTS investimentos;

CREATE TABLE IF NOT EXISTS investimentos.positions (
    id         UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    ticker     TEXT        NOT NULL,
    qty        NUMERIC     NOT NULL,
    avg_cost   NUMERIC     NOT NULL,
    currency   TEXT        NOT NULL DEFAULT 'BRL',
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS investimentos.orders (
    id         UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    ticker     TEXT        NOT NULL,
    side       TEXT        NOT NULL,
    qty        NUMERIC     NOT NULL,
    price      NUMERIC,
    status     TEXT        NOT NULL DEFAULT 'pending',
    strategy   TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 🛡️ SEGURANÇA
-- ============================================================
CREATE SCHEMA IF NOT EXISTS seguranca;

CREATE TABLE IF NOT EXISTS seguranca.events (
    id           UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    camera_id    TEXT        NOT NULL,
    event_type   TEXT        NOT NULL,
    confidence   NUMERIC,
    face_id      TEXT,
    video_path   TEXT,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS seguranca.known_faces (
    id           UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    name         TEXT        NOT NULL,
    embedding_id TEXT,
    user_id      UUID        REFERENCES people.pessoas(id),
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- Índices
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_sessions_user     ON mordomo.sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_memory_user       ON mordomo.long_term_memory(user_id);
CREATE INDEX IF NOT EXISTS idx_transactions_user ON financas.transactions(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_ticker     ON investimentos.orders(ticker);
CREATE INDEX IF NOT EXISTS idx_events_camera     ON seguranca.events(camera_id);
CREATE INDEX IF NOT EXISTS idx_events_created    ON seguranca.events(created_at DESC);
