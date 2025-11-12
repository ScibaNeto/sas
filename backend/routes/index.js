import express from 'express'
import authRoutes from './authRoutes.js'
import userRoutes from './userRoutes.js'

const router = express.Router()

// Health check
router.get('/health', (req, res) => {
  res.json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    uptime: process.uptime()
  })
})

// Rotas da API
router.use('/auth', authRoutes)
router.use('/users', userRoutes)

export default router



