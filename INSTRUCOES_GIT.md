# Instruções para Conectar ao GitHub

## Opção 1: Usar o Script Automático

Execute o script PowerShell que foi criado:

```powershell
.\setup-git.ps1
```

## Opção 2: Comandos Manuais

Se o Git estiver instalado, execute os seguintes comandos no PowerShell ou Git Bash:

```bash
# 1. Inicializar repositório Git
git init

# 2. Adicionar remote do GitHub
git remote add origin https://github.com/ScibaNeto/sas.git

# 3. Adicionar todos os arquivos
git add .

# 4. Fazer commit inicial
git commit -m "Initial commit: monorepo setup with backend"

# 5. Renomear branch para main (se necessário)
git branch -M main

# 6. Fazer push para o GitHub
git push -u origin main
```

## Se o Git não estiver instalado:

1. Baixe e instale o Git: https://git-scm.com/download/win
2. Durante a instalação, certifique-se de marcar a opção "Add Git to PATH"
3. Reinicie o terminal/PowerShell após a instalação
4. Execute os comandos acima novamente

## Autenticação no GitHub

Se for solicitada autenticação:

- **Token de acesso pessoal**: Vá em GitHub > Settings > Developer settings > Personal access tokens
- Crie um token com permissões de `repo`
- Use o token como senha quando solicitado

Ou configure SSH:
```bash
git remote set-url origin git@github.com:ScibaNeto/sas.git
```


