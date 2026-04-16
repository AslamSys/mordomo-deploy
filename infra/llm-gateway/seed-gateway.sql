-- ══════════════════════════════════════════════════════════════════════════
-- NEW-API SEED CONFIGURATION
-- ══════════════════════════════════════════════════════════════════════════
-- Este script configura os canais iniciais e o token de acesso do Brain.
-- Executado automaticamente pelo bootstrap.sh

-- 1. Canais
-- Inserções com tratamento de duplicidade para garantir replicabilidade
INSERT INTO channels (type, name, key, status, models, model_mapping, priority) 
SELECT 18, 'Groq-Auto', 'TEMP_GROQ_KEY', 1, 'llama-3.3-70b-versatile,mordomo-simple', '{"mordomo-simple": "llama-3.3-70b-versatile"}', 1
WHERE NOT EXISTS (SELECT 1 FROM channels WHERE name = 'Groq-Auto');

INSERT INTO channels (type, name, key, status, models, model_mapping, priority) 
SELECT 3, 'Gemini-Auto', 'TEMP_GEMINI_KEY', 1, 'gemini-1.5-flash-latest,mordomo-simple', '{"mordomo-simple": "gemini-1.5-flash-latest"}', 1
WHERE NOT EXISTS (SELECT 1 FROM channels WHERE name = 'Gemini-Auto');

-- 2. Token do Brain (Eterno)
INSERT INTO tokens (user_id, name, key, status, created_time, expired_time, remain_quota, unlimited_quota, used_quota) 
SELECT 1, 'Brain Key', 'sk-mordomo-master-key', 1, 1713290000, -1, 0, true, 0
WHERE NOT EXISTS (SELECT 1 FROM tokens WHERE key = 'sk-mordomo-master-key');
