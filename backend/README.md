# Backend - SAS

Backend API RESTful para o projeto SAS, construído com Node.js, Express e Supabase.

## Tecnologias

- **Node.js** - Runtime JavaScript
- **Express** - Framework web
- **Supabase** - Backend as a Service (BaaS)
- **Helmet** - Segurança HTTP
- **CORS** - Cross-Origin Resource Sharing
- **Express Rate Limit** - Proteção contra DDoS

## Estrutura do Projeto

```
backend/
├── config/
│   ├── supabase.js      # Configuração do Supabase
│   └── database.js      # Configuração do banco de dados
├── controllers/
│   ├── authController.js    # Controller de autenticação
│   └── userController.js    # Controller de usuários
├── middleware/
│   ├── auth.js          # Middleware de autenticação
│   └── errorHandler.js  # Tratamento de erros
├── routes/
│   ├── authRoutes.js    # Rotas de autenticação
│   ├── userRoutes.js    # Rotas de usuários
│   └── index.js         # Agregador de rotas
├── app.js               # Configuração do Express
├── server.js            # Entry point do servidor
├── package.json         # Dependências
└── env.example          # Exemplo de variáveis de ambiente
```

## Instalação

```bash
cd backend
npm install
```

## Configuração

1. Copie o arquivo `env.example` para `.env`:
```bash
cp env.example .env
```

2. Preencha as variáveis de ambiente no arquivo `.env`:
- `SUPABASE_URL`: URL do seu projeto Supabase
- `SUPABASE_ANON_KEY`: Chave pública (anon) do Supabase
- `SUPABASE_SERVICE_ROLE_KEY`: Chave de serviço (service role) do Supabase
- `DATABASE_URL`: String de conexão PostgreSQL do Supabase
- `PORT`: Porta do servidor (padrão: 3000)
- `NODE_ENV`: Ambiente (development/production)
- `CORS_ORIGIN`: URL do frontend (padrão: http://localhost:5173)

## Executar

```bash
# Modo desenvolvimento (com watch)
npm run dev

# Modo produção
npm start
```

O servidor estará disponível em `http://localhost:3000`

## Endpoints da API

### Health Check
- `GET /api/health` - Verifica status do servidor

### Autenticação
- `POST /api/auth/register` - Registra novo usuário
- `POST /api/auth/login` - Faz login
- `POST /api/auth/refresh` - Atualiza token
- `POST /api/auth/logout` - Faz logout (requer autenticação)
- `GET /api/auth/me` - Retorna usuário autenticado (requer autenticação)

### Usuários
- `GET /api/users` - Lista usuários (requer autenticação)
- `GET /api/users/:id` - Busca usuário por ID (requer autenticação)
- `PUT /api/users/:id` - Atualiza usuário (requer autenticação)
- `DELETE /api/users/:id` - Deleta usuário (requer autenticação)

## Autenticação

A API usa autenticação via Bearer Token do Supabase. Para fazer requisições autenticadas, inclua o header:

```
Authorization: Bearer <seu_token>
```

## Exemplos de Uso

### Registrar usuário
```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "password": "senha123"}'
```

### Login
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "password": "senha123"}'
```

### Buscar usuário autenticado
```bash
curl -X GET http://localhost:3000/api/auth/me \
  -H "Authorization: Bearer <seu_token>"
```

## Segurança

- **Helmet**: Configurado para segurança HTTP
- **Rate Limiting**: 100 requisições por IP a cada 15 minutos
- **CORS**: Configurado para aceitar apenas origem permitida
- **Autenticação**: Baseada em tokens JWT do Supabase



