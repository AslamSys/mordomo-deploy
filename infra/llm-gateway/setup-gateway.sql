-- ══════════════════════════════════════════════════════════════════════════
-- NEW-API MASTER BOOTSTRAP (ZERO-TOUCH DEPLOY)
-- ══════════════════════════════════════════════════════════════════════════

-- 1. Cria o Usuário Administrador (se não existir)
-- Senha padrão: 123456 (Hash oficial do New-API)
INSERT INTO users (id, username, password, role, status, quota, "group")
VALUES (1, 'root', '$2a$10$omgPVnzELawensprk5.hhOQAjOJ2vDxBeek8PBXkcLu1mQ0PdXCr.', 100, 1, 1000000000, 'default')
ON CONFLICT (id) DO UPDATE SET role = 100, quota = 1000000000;

-- 2. Ativa o Modo de Autoconsumo (Pula erros de preço)
INSERT INTO options (key, value) VALUES ('CommonSelfUseMode', 'true') 
ON CONFLICT (key) DO UPDATE SET value = 'true';

-- 3. Configura o Canal da Groq automaticamente
DELETE FROM channels WHERE name = 'Groq-Auto';
INSERT INTO channels (type, name, key, status, models, model_mapping, priority, "group")
VALUES (18, 'Groq-Auto', 'TEMP_GROQ_KEY', 1, 'llama-3.3-70b-versatile,mordomo-simple,mordomo-brain', '{"mordomo-simple": "llama-3.3-70b-versatile", "mordomo-brain": "llama-3.3-70b-versatile"}', 10, 'default');

-- 4. Cria o Token do Brain com valor fixo para o .env não precisar mudar
DELETE FROM tokens WHERE name = 'Brain';
INSERT INTO tokens (user_id, name, key, status, remain_quota, unlimited_quota, "group")
VALUES (1, 'Brain', 'mordomo_master_key', 1, 1000000000, true, 'default');
