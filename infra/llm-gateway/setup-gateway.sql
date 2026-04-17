-- ══════════════════════════════════════════════════════════════════════════
-- NEW-API MASTER BOOTSTRAP (AUTOMATED)
-- ══════════════════════════════════════════════════════════════════════════

-- 1. Cria o Usuário Root (Admin) se não existir
INSERT INTO users (id, username, password, role, status, quota)
VALUES (1, 'root', '$2a$10$K9x9rK./l.L3d.L3d.L3d.L3d.L3d.L3d.L3d.L3d.L3d.L3d.', 100, 1, 1000000000)
ON CONFLICT (id) DO UPDATE SET status = 1;

-- 2. Define o sistema como configurado (pula o Wizard da UI)
INSERT INTO options (key, value) VALUES ('SetupCompleted', 'true') 
ON CONFLICT (key) DO UPDATE SET value = 'true';

-- 3. Configura o Canal da Groq (Placeholder para a chave real)
INSERT INTO channels (type, name, key, status, models, model_mapping, priority, "group")
VALUES (18, 'Groq-Auto', 'TEMP_GROQ_KEY', 1, 'llama-3.3-70b-versatile,mordomo-simple,mordomo-brain', '{"mordomo-simple": "llama-3.3-70b-versatile", "mordomo-brain": "llama-3.3-70b-versatile"}', 10, 'default')
ON CONFLICT (name) DO UPDATE SET key = 'TEMP_GROQ_KEY', status = 1;

-- 4. Cria o Token Master para o Brain
INSERT INTO tokens (user_id, name, key, status, remain_quota, unlimited_quota, "group")
VALUES (1, 'Brain', 'sk-mordomo-master-key', 1, 1000000000, true, 'default')
ON CONFLICT (key) DO UPDATE SET status = 1, unlimited_quota = true;
