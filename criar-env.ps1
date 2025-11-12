# Script para criar arquivos .env a partir dos exemplos
# Execute: .\criar-env.ps1

Write-Host "📝 Criando arquivos .env..." -ForegroundColor Cyan

# Criar .env do backend
if (Test-Path "backend\env.example") {
    if (-not (Test-Path "backend\.env")) {
        Copy-Item "backend\env.example" "backend\.env"
        Write-Host "✅ Criado: backend\.env" -ForegroundColor Green
    } else {
        Write-Host "⚠️  backend\.env já existe (não foi sobrescrito)" -ForegroundColor Yellow
    }
} else {
    Write-Host "❌ Arquivo backend\env.example não encontrado" -ForegroundColor Red
}

# Criar .env do frontend
if (Test-Path "frontend\env.example") {
    if (-not (Test-Path "frontend\.env")) {
        Copy-Item "frontend\env.example" "frontend\.env"
        Write-Host "✅ Criado: frontend\.env" -ForegroundColor Green
    } else {
        Write-Host "⚠️  frontend\.env já existe (não foi sobrescrito)" -ForegroundColor Yellow
    }
} else {
    Write-Host "❌ Arquivo frontend\env.example não encontrado" -ForegroundColor Red
}

Write-Host "`n📋 Próximos passos:" -ForegroundColor Cyan
Write-Host "1. Edite backend\.env e preencha com suas credenciais do Supabase" -ForegroundColor Yellow
Write-Host "2. Edite frontend\.env e preencha com suas credenciais do Supabase" -ForegroundColor Yellow
Write-Host "3. Veja CONFIGURAR_ENV.md para instruções detalhadas" -ForegroundColor Yellow
Write-Host "`n🔗 Obtenha as credenciais em: https://app.supabase.com" -ForegroundColor Cyan
Write-Host "   Vá em Settings, depois API" -ForegroundColor Cyan

