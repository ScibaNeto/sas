# SAS - Monorepo

Repositório monorepo para o projeto SAS.

## Estrutura do Projeto

```
.
├── backend/
│   ├── config/           # Configurações (Supabase, Database)
│   ├── controllers/      # Controllers (Auth, Users)
│   ├── middleware/       # Middlewares (Auth, Error Handler)
│   ├── routes/           # Rotas da API
│   ├── app.js            # Configuração do Express
│   ├── server.js         # Entry point
│   ├── package.json      # Dependências do backend
│   └── env.example       # Exemplo de variáveis de ambiente
├── frontend/
│   ├── src/              # Código fonte do frontend
│   │   ├── pages/        # Páginas (Home, Login, Dashboard)
│   │   ├── lib/          # Bibliotecas (Supabase)
│   │   └── ...
│   ├── env.example       # Exemplo de variáveis de ambiente
│   ├── package.json      # Dependências do frontend
│   └── vite.config.js    # Configuração do Vite
└── README.md
```

## Configuração

### Backend

#### Instalação

```bash
cd backend
npm install
```

#### Variáveis de Ambiente

Copie o arquivo `env.example` para `.env` e preencha com suas credenciais do Supabase:

```bash
cp backend/env.example backend/.env
```

#### Variáveis Necessárias

- `SUPABASE_URL`: URL do seu projeto Supabase
- `SUPABASE_ANON_KEY`: Chave pública (anon) do Supabase
- `SUPABASE_SERVICE_ROLE_KEY`: Chave de serviço (service role) do Supabase
- `DATABASE_URL`: String de conexão PostgreSQL do Supabase
- `JWT_SECRET`: Chave secreta para JWT (opcional)
- `NODE_ENV`: Ambiente (development/production)
- `PORT`: Porta do servidor (padrão: 3000)
- `CORS_ORIGIN`: URL do frontend (padrão: http://localhost:5173)

#### Executar

```bash
cd backend
npm run dev    # Modo desenvolvimento (com watch)
npm start      # Modo produção
```

O backend estará disponível em `http://localhost:3000`

#### Endpoints da API

- `GET /api/health` - Health check
- `POST /api/auth/register` - Registrar usuário
- `POST /api/auth/login` - Login
- `POST /api/auth/refresh` - Atualizar token
- `POST /api/auth/logout` - Logout (requer autenticação)
- `GET /api/auth/me` - Usuário autenticado (requer autenticação)
- `GET /api/users` - Listar usuários (requer autenticação)
- `GET /api/users/:id` - Buscar usuário (requer autenticação)
- `PUT /api/users/:id` - Atualizar usuário (requer autenticação)
- `DELETE /api/users/:id` - Deletar usuário (requer autenticação)

### Frontend

#### Instalação

```bash
cd frontend
npm install
```

#### Variáveis de Ambiente

Copie o arquivo `env.example` para `.env`:

```bash
cp frontend/env.example frontend/.env
```

#### Variáveis Necessárias

- `VITE_SUPABASE_URL`: URL do seu projeto Supabase
- `VITE_SUPABASE_ANON_KEY`: Chave pública (anon) do Supabase
- `VITE_API_URL`: URL do backend (padrão: http://localhost:3000)

#### Executar

```bash
cd frontend
npm run dev
```

O frontend estará disponível em `http://localhost:5173`

## Como Obter as Credenciais do Supabase

1. Acesse o [Dashboard do Supabase](https://app.supabase.com)
2. Selecione seu projeto
3. Vá em **Settings** > **API**
4. Copie:
   - **Project URL** → `SUPABASE_URL`
   - **anon public** key → `SUPABASE_ANON_KEY`
   - **service_role** key → `SUPABASE_SERVICE_ROLE_KEY`
5. Para `DATABASE_URL`, vá em **Settings** > **Database** e copie a connection string

## Configuração do Git

Para conectar este repositório ao GitHub:

```bash
# Inicializar repositório (se ainda não foi feito)
git init

# Adicionar remote
git remote add origin https://github.com/ScibaNeto/sas.git

# Adicionar arquivos
git add .

# Fazer commit
git commit -m "Initial commit"

# Fazer push
git push -u origin main
```

Ou execute o script PowerShell:
```powershell
.\setup-git.ps1
```

