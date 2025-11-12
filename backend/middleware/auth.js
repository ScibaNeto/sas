import { supabaseAdmin } from '../config/supabase.js'

/**
 * Middleware de autenticação
 * Verifica se o usuário está autenticado via token do Supabase
 */
export const authenticate = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(401).json({
        error: 'Token de autenticação não fornecido',
        message: 'Por favor, forneça um token Bearer válido'
      })
    }

    const token = authHeader.substring(7) // Remove "Bearer "

    // Verifica o token com o Supabase
    const { data: { user }, error } = await supabaseAdmin.auth.getUser(token)

    if (error || !user) {
      return res.status(401).json({
        error: 'Token inválido ou expirado',
        message: 'Por favor, faça login novamente'
      })
    }

    // Adiciona o usuário ao request
    req.user = user
    next()
  } catch (error) {
    console.error('Erro na autenticação:', error)
    return res.status(500).json({
      error: 'Erro interno na autenticação',
      message: error.message
    })
  }
}

/**
 * Middleware opcional de autenticação
 * Não bloqueia a requisição se não houver token
 */
export const optionalAuth = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization

    if (authHeader && authHeader.startsWith('Bearer ')) {
      const token = authHeader.substring(7)
      const { data: { user } } = await supabaseAdmin.auth.getUser(token)
      req.user = user
    }

    next()
  } catch (error) {
    // Continua sem autenticação em caso de erro
    next()
  }
}


