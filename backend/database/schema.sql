-- ============================================
-- Schema SQL para Supabase
-- Projeto: SAS
-- ============================================

-- ============================================
-- Extensões
-- ============================================
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- Tabela: Perfis de Usuário
-- ============================================
-- Esta tabela estende a tabela auth.users do Supabase
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    full_name TEXT,
    avatar_url TEXT,
    phone TEXT,
    bio TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Índices para perfis
CREATE INDEX IF NOT EXISTS idx_profiles_created_at ON public.profiles(created_at);

-- ============================================
-- Tabela: Categorias
-- ============================================
CREATE TABLE IF NOT EXISTS public.categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    description TEXT,
    slug TEXT UNIQUE NOT NULL,
    icon TEXT,
    color TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Índices para categorias
CREATE INDEX IF NOT EXISTS idx_categories_slug ON public.categories(slug);
CREATE INDEX IF NOT EXISTS idx_categories_is_active ON public.categories(is_active);

-- ============================================
-- Tabela: Itens/Produtos
-- ============================================
CREATE TABLE IF NOT EXISTS public.items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    description TEXT,
    category_id UUID REFERENCES public.categories(id) ON DELETE SET NULL,
    price DECIMAL(10, 2),
    stock INTEGER DEFAULT 0,
    sku TEXT UNIQUE,
    image_url TEXT,
    is_active BOOLEAN DEFAULT true,
    created_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Índices para itens
CREATE INDEX IF NOT EXISTS idx_items_category_id ON public.items(category_id);
CREATE INDEX IF NOT EXISTS idx_items_sku ON public.items(sku);
CREATE INDEX IF NOT EXISTS idx_items_is_active ON public.items(is_active);
CREATE INDEX IF NOT EXISTS idx_items_created_by ON public.items(created_by);

-- ============================================
-- Tabela: Pedidos/Ordens
-- ============================================
CREATE TABLE IF NOT EXISTS public.orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    order_number TEXT UNIQUE NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'completed', 'cancelled')),
    total_amount DECIMAL(10, 2) NOT NULL DEFAULT 0,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Índices para pedidos
CREATE INDEX IF NOT EXISTS idx_orders_user_id ON public.orders(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_order_number ON public.orders(order_number);
CREATE INDEX IF NOT EXISTS idx_orders_status ON public.orders(status);
CREATE INDEX IF NOT EXISTS idx_orders_created_at ON public.orders(created_at);

-- ============================================
-- Tabela: Itens do Pedido
-- ============================================
CREATE TABLE IF NOT EXISTS public.order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID REFERENCES public.orders(id) ON DELETE CASCADE NOT NULL,
    item_id UUID REFERENCES public.items(id) ON DELETE RESTRICT NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Índices para itens do pedido
CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON public.order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_order_items_item_id ON public.order_items(item_id);

-- ============================================
-- Tabela: Notificações
-- ============================================
CREATE TABLE IF NOT EXISTS public.notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    type TEXT DEFAULT 'info' CHECK (type IN ('info', 'success', 'warning', 'error')),
    is_read BOOLEAN DEFAULT false,
    link TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Índices para notificações
CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON public.notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_notifications_is_read ON public.notifications(is_read);
CREATE INDEX IF NOT EXISTS idx_notifications_created_at ON public.notifications(created_at);

-- ============================================
-- Função: Atualizar updated_at automaticamente
-- ============================================
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = TIMEZONE('utc'::text, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers para atualizar updated_at
CREATE TRIGGER set_updated_at_profiles
    BEFORE UPDATE ON public.profiles
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER set_updated_at_categories
    BEFORE UPDATE ON public.categories
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER set_updated_at_items
    BEFORE UPDATE ON public.items
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER set_updated_at_orders
    BEFORE UPDATE ON public.orders
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_updated_at();

-- ============================================
-- Função: Gerar número de pedido
-- ============================================
CREATE OR REPLACE FUNCTION public.generate_order_number()
RETURNS TEXT AS $$
DECLARE
    new_order_number TEXT;
BEGIN
    new_order_number := 'ORD-' || TO_CHAR(NOW(), 'YYYYMMDD') || '-' || LPAD(NEXTVAL('order_sequence')::TEXT, 6, '0');
    RETURN new_order_number;
END;
$$ LANGUAGE plpgsql;

-- Sequência para números de pedido
CREATE SEQUENCE IF NOT EXISTS order_sequence START 1;

-- ============================================
-- RLS (Row Level Security) Policies
-- ============================================

-- Habilitar RLS em todas as tabelas
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- Políticas para Profiles
CREATE POLICY "Users can view own profile"
    ON public.profiles FOR SELECT
    USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
    ON public.profiles FOR UPDATE
    USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile"
    ON public.profiles FOR INSERT
    WITH CHECK (auth.uid() = id);

-- Políticas para Categories (público pode ler, apenas autenticados podem modificar)
CREATE POLICY "Anyone can view active categories"
    ON public.categories FOR SELECT
    USING (is_active = true);

CREATE POLICY "Authenticated users can manage categories"
    ON public.categories FOR ALL
    USING (auth.role() = 'authenticated');

-- Políticas para Items (público pode ler ativos, autenticados podem modificar)
CREATE POLICY "Anyone can view active items"
    ON public.items FOR SELECT
    USING (is_active = true);

CREATE POLICY "Authenticated users can manage items"
    ON public.items FOR ALL
    USING (auth.role() = 'authenticated');

-- Políticas para Orders (usuários só veem seus próprios pedidos)
CREATE POLICY "Users can view own orders"
    ON public.orders FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can create own orders"
    ON public.orders FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own orders"
    ON public.orders FOR UPDATE
    USING (auth.uid() = user_id);

-- Políticas para Order Items (baseado no pedido)
CREATE POLICY "Users can view own order items"
    ON public.order_items FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM public.orders
            WHERE orders.id = order_items.order_id
            AND orders.user_id = auth.uid()
        )
    );

CREATE POLICY "Users can create own order items"
    ON public.order_items FOR INSERT
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.orders
            WHERE orders.id = order_items.order_id
            AND orders.user_id = auth.uid()
        )
    );

-- Políticas para Notifications (usuários só veem suas notificações)
CREATE POLICY "Users can view own notifications"
    ON public.notifications FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can update own notifications"
    ON public.notifications FOR UPDATE
    USING (auth.uid() = user_id);

-- ============================================
-- Dados Iniciais (Seed)
-- ============================================

-- Inserir categorias padrão
INSERT INTO public.categories (name, description, slug, color) VALUES
    ('Eletrônicos', 'Produtos eletrônicos e tecnologia', 'eletronicos', '#3B82F6'),
    ('Roupas', 'Vestuário e acessórios', 'roupas', '#EF4444'),
    ('Casa e Jardim', 'Itens para casa e jardim', 'casa-jardim', '#10B981'),
    ('Esportes', 'Artigos esportivos', 'esportes', '#F59E0B'),
    ('Livros', 'Livros e materiais de leitura', 'livros', '#8B5CF6')
ON CONFLICT (slug) DO NOTHING;

-- ============================================
-- Comentários nas Tabelas
-- ============================================
COMMENT ON TABLE public.profiles IS 'Perfis de usuário que estendem auth.users';
COMMENT ON TABLE public.categories IS 'Categorias de produtos/itens';
COMMENT ON TABLE public.items IS 'Produtos ou itens do sistema';
COMMENT ON TABLE public.orders IS 'Pedidos/Ordens do sistema';
COMMENT ON TABLE public.order_items IS 'Itens que compõem um pedido';
COMMENT ON TABLE public.notifications IS 'Notificações dos usuários';



