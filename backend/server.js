import app from './app.js'
import { testConnection } from './config/database.js'
import dotenv from 'dotenv'

dotenv.config()

const PORT = process.env.PORT || 3000
const NODE_ENV = process.env.NODE_ENV || 'development'

// Testa conexão com o banco antes de iniciar
testConnection().then(() => {
  app.listen(PORT, () => {
    console.log(`
🚀 Servidor iniciado com sucesso!
📍 Ambiente: ${NODE_ENV}
🌐 URL: http://localhost:${PORT}
📚 API: http://localhost:${PORT}/api
    `)
  })
}).catch((error) => {
  console.error('❌ Erro ao iniciar servidor:', error)
  process.exit(1)
})

// Tratamento de erros não capturados
process.on('unhandledRejection', (error) => {
  console.error('Unhandled Rejection:', error)
  process.exit(1)
})

process.on('uncaughtException', (error) => {
  console.error('Uncaught Exception:', error)
  process.exit(1)
})



