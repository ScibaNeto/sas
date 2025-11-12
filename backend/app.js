import express from 'express'
import cors from 'cors'
import helmet from 'helmet'
import rateLimit from 'express-rate-limit'
import dotenv from 'dotenv'
import routes from './routes/index.js'
import { errorHandler, notFound } from './middleware/errorHandler.js'

dotenv.config()

const app = express()

// Configuração de segurança
app.use(helmet())

// CORS
const corsOptions = {
  origin: process.env.CORS_ORIGIN || 'http://localhost:5173',
  credentials: true,
  optionsSuccessStatus: 200
}
app.use(cors(corsOptions))

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutos
  max: 100, // máximo 100 requisições por IP
  message: 'Muitas requisições deste IP, tente novamente mais tarde.'
})
app.use('/api/', limiter)

// Body parser
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

// Logging básico
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`)
  next()
})

// Rotas
app.use('/api', routes)

// Rota raiz
app.get('/', (req, res) => {
  res.json({
    message: 'API SAS - Backend',
    version: '1.0.0',
    endpoints: {
      health: '/api/health',
      auth: '/api/auth',
      users: '/api/users'
    }
  })
})

// Middleware de erro
app.use(notFound)
app.use(errorHandler)

export default app



