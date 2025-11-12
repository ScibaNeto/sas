# Database Schema - Supabase

Este diretório contém os arquivos SQL para configurar o banco de dados no Supabase.

## Arquivos

- `schema.sql` - Schema completo com tabelas, índices, triggers e políticas RLS

## Como Usar

### Opção 1: Via Dashboard do Supabase

1. Acesse o [Dashboard do Supabase](https://app.supabase.com)
2. Selecione seu projeto
3. Vá em **SQL Editor**
4. Copie e cole o conteúdo do arquivo `schema.sql`
5. Clique em **Run** para executar

### Opção 2: Via Supabase CLI

```bash
# Instalar Supabase CLI (se ainda não tiver)
npm install -g supabase

# Fazer login
supabase login

# Vincular ao projeto
supabase link --project-ref seu-project-ref

# Executar o schema
supabase db push
```

### Opção 3: Via Migrations

1. Crie uma migration no Supabase:
   - Dashboard > Database > Migrations > New Migration
2. Cole o conteúdo do `schema.sql`
3. Execute a migration

## Estrutura das Tabelas

### 1. `profiles`
Perfis de usuário que estendem `auth.users` do Supabase
- `id` - UUID (referência a auth.users)
- `full_name` - Nome completo
- `avatar_url` - URL do avatar
- `phone` - Telefone
- `bio` - Biografia

### 2. `categories`
Categorias de produtos/itens
- `id` - UUID
- `name` - Nome da categoria
- `slug` - Slug único
- `is_active` - Se está ativa

### 3. `items`
Produtos ou itens do sistema
- `id` - UUID
- `name` - Nome do item
- `category_id` - Referência à categoria
- `price` - Preço
- `stock` - Estoque
- `sku` - Código SKU único

### 4. `orders`
Pedidos/Ordens
- `id` - UUID
- `user_id` - Usuário que fez o pedido
- `order_number` - Número único do pedido
- `status` - Status (pending, processing, completed, cancelled)
- `total_amount` - Valor total

### 5. `order_items`
Itens que compõem um pedido
- `id` - UUID
- `order_id` - Referência ao pedido
- `item_id` - Referência ao item
- `quantity` - Quantidade
- `unit_price` - Preço unitário
- `subtotal` - Subtotal

### 6. `notifications`
Notificações dos usuários
- `id` - UUID
- `user_id` - Usuário destinatário
- `title` - Título
- `message` - Mensagem
- `type` - Tipo (info, success, warning, error)
- `is_read` - Se foi lida

## Segurança (RLS)

Todas as tabelas têm Row Level Security (RLS) habilitado com políticas que:
- Permitem que usuários vejam apenas seus próprios dados
- Permitem leitura pública de itens e categorias ativos
- Restringem modificações apenas para usuários autenticados

## Triggers

- `handle_updated_at()` - Atualiza automaticamente o campo `updated_at` quando um registro é modificado
- `generate_order_number()` - Gera números de pedido únicos

## Dados Iniciais

O schema inclui categorias padrão que são inseridas automaticamente.



