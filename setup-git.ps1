# Script para configurar e fazer push para o GitHub
# Execute este script no PowerShell: .\setup-git.ps1

Write-Host "Configurando repositório Git..." -ForegroundColor Green

# Verificar se o Git está instalado
$gitPath = $null
if (Get-Command git -ErrorAction SilentlyContinue) {
    $gitPath = "git"
} elseif (Test-Path "C:\Program Files\Git\bin\git.exe") {
    $gitPath = "C:\Program Files\Git\bin\git.exe"
} elseif (Test-Path "C:\Program Files (x86)\Git\bin\git.exe") {
    $gitPath = "C:\Program Files (x86)\Git\bin\git.exe"
} else {
    Write-Host "ERRO: Git não encontrado. Por favor, instale o Git primeiro." -ForegroundColor Red
    Write-Host "Download: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

# Inicializar repositório Git (se não existir)
if (-not (Test-Path ".git")) {
    Write-Host "Inicializando repositório Git..." -ForegroundColor Yellow
    & $gitPath init
}

# Adicionar remote origin
Write-Host "Configurando remote origin..." -ForegroundColor Yellow
& $gitPath remote remove origin 2>$null
& $gitPath remote add origin https://github.com/ScibaNeto/sas.git

# Adicionar todos os arquivos
Write-Host "Adicionando arquivos..." -ForegroundColor Yellow
& $gitPath add .

# Fazer commit inicial
Write-Host "Fazendo commit..." -ForegroundColor Yellow
& $gitPath commit -m "Initial commit: monorepo setup with backend"

# Verificar branch atual
$branch = & $gitPath branch --show-current
if (-not $branch) {
    & $gitPath branch -M main
    $branch = "main"
}

# Fazer push
Write-Host "Fazendo push para o GitHub..." -ForegroundColor Yellow
& $gitPath push -u origin $branch

Write-Host "`nConcluído! Repositório configurado e enviado para o GitHub." -ForegroundColor Green


