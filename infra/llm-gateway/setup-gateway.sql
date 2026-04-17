-- ══════════════════════════════════════════════════════════════════════════
-- NEW-API MASTER BOOTSTRAP (AUTOMATED)
-- ══════════════════════════════════════════════════════════════════════════

-- 0. Correção de Tipos e Limpeza
ALTER TABLE users ALTER COLUMN username TYPE text;
ALTER TABLE tokens ALTER COLUMN key TYPE text;
ALTER TABLE channels ALTER COLUMN name TYPE text;

-- 1. Setup do Usuário Root (Admin)
DELETE FROM users WHERE id = 1;
INSERT INTO users (id, username, password, role, status, quota)
VALUES (1, 'root', '$2a$10$K9x9rK./l.L3d.L3d.L3d.L3d.L3d.L3d.L3d.L3d.L3d.L3d.', 100, 1, 1000000000);

-- 2. Setup de Opções Globais
DELETE FROM options WHERE key = 'SetupCompleted';
INSERT INTO options (key, value) VALUES ('SetupCompleted', 'true');

-- 3. Setup dos Canais (Groq)
DELETE FROM channels WHERE name = 'Groq-Auto';
INSERT INTO channels (type, name, key, status, models, model_mapping, priority, "group")
VALUES (18, 'Groq-Auto', 'TEMP_GROQ_KEY', 1, 'llama-3.3-70b-versatile,mordomo-simple,mordomo-brain', '{"mordomo-simple": "llama-3.3-70b-versatile", "mordomo-brain": "llama-3.3-70b-versatile"}', 10, 'default');

-- 4. Setup dos Tokens (Brain Key - SEM HÍFEN PARA COMPATIBILIDADE)
DELETE FROM tokens WHERE name = 'Brain';
INSERT INTO tokens (user_id, name, key, status, remain_quota, unlimited_quota, "group")
VALUES (1, 'Brain', 'mordomo_master_key', 1, 1000000000, true, 'default');
