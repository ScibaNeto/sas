# Como Configurar os Arquivos .env

## ⚠️ Importante
Os arquivos `.env` não são versionados no Git por segurança. Você precisa configurá-los localmente.

## 📋 Passo a Passo

### 1. Backend (.env)

Arquivo: `backend/.env`

#### Como obter as credenciais do Supabase:

1. Acesse o [Dashboard do Supabase](https://app.supabase.com)
2. Selecione seu projeto (ou crie um novo)
3. Vá em **Settings** > **API**
4. Copie os seguintes valores:

   - **Project URL** → `SUPABASE_URL`
   - **anon public** key → `SUPABASE_ANON_KEY`
   - **service_role** key → `SUPABASE_SERVICE_ROLE_KEY` ⚠️ (mantenha secreto!)

5. Para `DATABASE_URL`:
   - Vá em **Settings** > **Database**
   - Copie a **Connection string** (URI)
   - Substitua `[YOUR-PASSWORD]` pela senha do banco
   - Substitua `[YOUR-PROJECT-REF]` pela referência do projeto

#### Exemplo de `backend/.env`:

```env
SUPABASE_URL=https://xxxxxxxxxxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
DATABASE_URL=postgresql://postgres:senha123@db.xxxxxxxxxxxxx.supabase.co:5432/postgres
JWT_SECRET=minha_chave_secreta_super_segura_aqui
NODE_ENV=development
PORT=3000
CORS_ORIGIN=http://localhost:5173
```

### 2. Frontend (.env)

Arquivo: `frontend/.env`

Use as mesmas credenciais do backend (mas apenas as públicas):

#### Exemplo de `frontend/.env`:

```env
VITE_SUPABASE_URL=https://xxxxxxxxxxxxx.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
VITE_API_URL=http://localhost:3000
```

## 🔐 Segurança

- ⚠️ **NUNCA** commite arquivos `.env` no Git
- ⚠️ **NUNCA** compartilhe suas chaves publicamente
- ⚠️ A `SERVICE_ROLE_KEY` tem acesso total - mantenha secreta!
- ✅ Use `.env.example` como referência
- ✅ Adicione `.env` ao `.gitignore` (já está configurado)

## 🚀 Após Configurar

1. **Backend:**
   ```bash
   cd backend
   npm install
   npm run dev
   ```

2. **Frontend:**
   ```bash
   cd frontend
   npm install
   npm run dev
   ```

## 📝 Gerar JWT Secret (Opcional)

Se quiser gerar uma chave JWT segura:

```bash
# No terminal
openssl rand -base64 32

# Ou no PowerShell
[Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Minimum 0 -Maximum 256 }))
```

Cole o resultado em `JWT_SECRET` no `backend/.env`.

## ✅ Verificação

Após configurar, teste se está funcionando:

1. Backend deve iniciar sem erros
2. Frontend deve conectar ao Supabase
3. Verifique os logs para erros de conexão




