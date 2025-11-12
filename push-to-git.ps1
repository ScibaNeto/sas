# Script melhorado para fazer push para o GitHub
# Tenta encontrar o Git em vários locais

Write-Host "🔍 Procurando Git..." -ForegroundColor Cyan

# Lista de possíveis locais do Git
$possiblePaths = @(
    "git",
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "$env:LOCALAPPDATA\Programs\Git\bin\git.exe",
    "$env:ProgramFiles\Git\cmd\git.exe",
    "$env:ProgramFiles(x86)\Git\cmd\git.exe"
)

$gitPath = $null

foreach ($path in $possiblePaths) {
    try {
        if ($path -eq "git") {
            $cmd = Get-Command git -ErrorAction SilentlyContinue
            if ($cmd) {
                $gitPath = "git"
                Write-Host "✅ Git encontrado no PATH" -ForegroundColor Green
                break
            }
        } elseif (Test-Path $path) {
            $gitPath = $path
            Write-Host "✅ Git encontrado em: $path" -ForegroundColor Green
            break
        }
    } catch {
        continue
    }
}

if (-not $gitPath) {
    Write-Host "`n❌ Git não encontrado!" -ForegroundColor Red
    Write-Host "`nPor favor, instale o Git:" -ForegroundColor Yellow
    Write-Host "1. Baixe em: https://git-scm.com/download/win" -ForegroundColor Cyan
    Write-Host "2. Durante a instalação, marque 'Add Git to PATH'" -ForegroundColor Cyan
    Write-Host "3. Reinicie o PowerShell e execute este script novamente" -ForegroundColor Cyan
    Write-Host "`nOu execute os comandos manualmente (veja COMANDOS_GIT.md)" -ForegroundColor Yellow
    exit 1
}

Write-Host "`n📦 Configurando repositório Git..." -ForegroundColor Green

# Inicializar repositório
if (-not (Test-Path ".git")) {
    Write-Host "Inicializando repositório..." -ForegroundColor Yellow
    & $gitPath init
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Erro ao inicializar repositório" -ForegroundColor Red
        exit 1
    }
}

# Configurar remote
Write-Host "Configurando remote origin..." -ForegroundColor Yellow
& $gitPath remote remove origin 2>$null
& $gitPath remote add origin https://github.com/ScibaNeto/sas.git
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  Remote já existe ou erro ao configurar" -ForegroundColor Yellow
}

# Adicionar arquivos
Write-Host "Adicionando arquivos..." -ForegroundColor Yellow
& $gitPath add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erro ao adicionar arquivos" -ForegroundColor Red
    exit 1
}

# Verificar se há mudanças para commitar
$status = & $gitPath status --porcelain
if (-not $status) {
    Write-Host "ℹ️  Nenhuma mudança para commitar" -ForegroundColor Cyan
} else {
    # Fazer commit
    Write-Host "Fazendo commit..." -ForegroundColor Yellow
    & $gitPath commit -m "Initial commit: monorepo com backend e frontend completo"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Erro ao fazer commit" -ForegroundColor Red
        exit 1
    }
}

# Verificar branch
$branch = & $gitPath branch --show-current
if (-not $branch) {
    Write-Host "Criando branch main..." -ForegroundColor Yellow
    & $gitPath branch -M main
    $branch = "main"
}

# Fazer push
Write-Host "`n🚀 Fazendo push para o GitHub..." -ForegroundColor Green
Write-Host "⚠️  Você pode precisar autenticar (token ou senha)" -ForegroundColor Yellow
& $gitPath push -u origin $branch

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✅ Sucesso! Código enviado para o GitHub!" -ForegroundColor Green
    Write-Host "🔗 https://github.com/ScibaNeto/sas" -ForegroundColor Cyan
} else {
    Write-Host "`n❌ Erro ao fazer push" -ForegroundColor Red
    Write-Host "`nPossíveis causas:" -ForegroundColor Yellow
    Write-Host "1. Problemas de autenticação (crie um token em GitHub)" -ForegroundColor Cyan
    Write-Host "2. Repositório remoto não está vazio" -ForegroundColor Cyan
    Write-Host "3. Verifique sua conexão com a internet" -ForegroundColor Cyan
    Write-Host "`nVeja COMANDOS_GIT.md para mais informações" -ForegroundColor Yellow
}



