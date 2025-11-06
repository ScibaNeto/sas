# Frontend - SAS

Frontend do projeto SAS construído com React e Vite.

## Tecnologias

- **React 18** - Biblioteca UI
- **Vite** - Build tool e dev server
- **React Router** - Roteamento
- **Supabase** - Autenticação e backend
- **React Hot Toast** - Notificações

## Instalação

```bash
cd frontend
npm install
```

## Configuração

1. Copie o arquivo `.env.example` para `.env`:
```bash
cp .env.example .env
```

2. Preencha as variáveis de ambiente:
- `VITE_SUPABASE_URL`: URL do seu projeto Supabase
- `VITE_SUPABASE_ANON_KEY`: Chave pública (anon) do Supabase
- `VITE_API_URL`: URL do backend (padrão: http://localhost:3000)

## Executar

```bash
# Modo desenvolvimento
npm run dev

# Build para produção
npm run build

# Preview do build
npm run preview
```

O frontend estará disponível em `http://localhost:5173`

## Estrutura

```
frontend/
├── src/
│   ├── pages/          # Páginas da aplicação
│   ├── lib/            # Bibliotecas e configurações
│   ├── App.jsx         # Componente principal
│   └── main.jsx        # Entry point
├── public/             # Arquivos estáticos
├── index.html          # HTML principal
└── vite.config.js      # Configuração do Vite
```

