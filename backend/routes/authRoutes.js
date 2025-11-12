import express from 'express'
import { authController } from '../controllers/authController.js'
import { authenticate } from '../middleware/auth.js'

const router = express.Router()

// Rotas públicas
router.post('/register', authController.register)
router.post('/login', authController.login)
router.post('/refresh', authController.refreshToken)

// Rotas protegidas
router.post('/logout', authenticate, authController.logout)
router.get('/me', authenticate, authController.me)

export default router


