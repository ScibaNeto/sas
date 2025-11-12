-- ============================================
-- Dados de Exemplo (Seed) para Supabase
-- Execute este arquivo após o schema.sql
-- ============================================

-- Inserir itens de exemplo (após criar categorias)
-- Nota: Ajuste os category_id conforme os IDs gerados no schema.sql

INSERT INTO public.items (name, description, category_id, price, stock, sku, is_active) 
SELECT 
    'Smartphone XYZ',
    'Smartphone com 128GB de armazenamento',
    id,
    1299.99,
    50,
    'ELET-001',
    true
FROM public.categories 
WHERE slug = 'eletronicos'
LIMIT 1
ON CONFLICT (sku) DO NOTHING;

INSERT INTO public.items (name, description, category_id, price, stock, sku, is_active) 
SELECT 
    'Camiseta Básica',
    'Camiseta 100% algodão',
    id,
    49.90,
    100,
    'ROUP-001',
    true
FROM public.categories 
WHERE slug = 'roupas'
LIMIT 1
ON CONFLICT (sku) DO NOTHING;

INSERT INTO public.items (name, description, category_id, price, stock, sku, is_active) 
SELECT 
    'Vaso Decorativo',
    'Vaso de cerâmica para plantas',
    id,
    79.90,
    30,
    'CASA-001',
    true
FROM public.categories 
WHERE slug = 'casa-jardim'
LIMIT 1
ON CONFLICT (sku) DO NOTHING;

-- Exemplo de notificação (substitua o user_id por um ID real de usuário)
-- INSERT INTO public.notifications (user_id, title, message, type)
-- VALUES (
--     '00000000-0000-0000-0000-000000000000', -- Substitua por um user_id real
--     'Bem-vindo!',
--     'Bem-vindo ao sistema SAS!',
--     'success'
-- );


