# Comandos Git para Fazer Push

Execute estes comandos no terminal (PowerShell, Git Bash ou CMD):

## Opção 1: Se o Git estiver no PATH

```bash
# 1. Inicializar repositório
git init

# 2. Adicionar remote
git remote add origin https://github.com/ScibaNeto/sas.git

# 3. Adicionar todos os arquivos
git add .

# 4. Fazer commit
git commit -m "Initial commit: monorepo com backend e frontend"

# 5. Renomear branch para main
git branch -M main

# 6. Fazer push
git push -u origin main
```

## Opção 2: Se precisar usar caminho completo do Git

Substitua `git` pelo caminho completo, por exemplo:
- `"C:\Program Files\Git\bin\git.exe"` 
- `"C:\Program Files (x86)\Git\bin\git.exe"`

```powershell
# Exemplo no PowerShell
& "C:\Program Files\Git\bin\git.exe" init
& "C:\Program Files\Git\bin\git.exe" remote add origin https://github.com/ScibaNeto/sas.git
& "C:\Program Files\Git\bin\git.exe" add .
& "C:\Program Files\Git\bin\git.exe" commit -m "Initial commit: monorepo com backend e frontend"
& "C:\Program Files\Git\bin\git.exe" branch -M main
& "C:\Program Files\Git\bin\git.exe" push -u origin main
```

## Opção 3: Usar GitHub Desktop

1. Abra o GitHub Desktop
2. File > Add Local Repository
3. Selecione a pasta do projeto
4. Commit e Push

## Autenticação

Se for solicitada autenticação:

1. **Token de Acesso Pessoal** (recomendado):
   - Vá em GitHub > Settings > Developer settings > Personal access tokens > Tokens (classic)
   - Crie um token com permissão `repo`
   - Use o token como senha quando solicitado

2. **Ou configure SSH**:
   ```bash
   git remote set-url origin git@github.com:ScibaNeto/sas.git
   ```

## Verificar se o Git está instalado

```powershell
# No PowerShell
Get-Command git -ErrorAction SilentlyContinue

# Ou
where.exe git
```

Se não encontrar, instale o Git: https://git-scm.com/download/win



