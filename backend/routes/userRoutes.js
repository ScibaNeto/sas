import express from 'express'
import { userController } from '../controllers/userController.js'
import { authenticate } from '../middleware/auth.js'

const router = express.Router()

// Todas as rotas de usuários requerem autenticação
router.use(authenticate)

router.get('/', userController.list)
router.get('/:id', userController.getById)
router.put('/:id', userController.update)
router.delete('/:id', userController.delete)

export default router



