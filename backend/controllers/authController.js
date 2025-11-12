import { supabaseAdmin } from '../config/supabase.js'

/**
 * Controller de autenticação
 */
export const authController = {
  /**
   * Registra um novo usuário
   */
  async register(req, res) {
    try {
      const { email, password, metadata } = req.body

      if (!email || !password) {
        return res.status(400).json({
          error: 'Email e senha são obrigatórios'
        })
      }

      const { data, error } = await supabaseAdmin.auth.admin.createUser({
        email,
        password,
        email_confirm: true, // Confirma email automaticamente
        user_metadata: metadata || {}
      })

      if (error) {
        return res.status(400).json({
          error: 'Erro ao criar usuário',
          message: error.message
        })
      }

      res.status(201).json({
        message: 'Usuário criado com sucesso',
        user: {
          id: data.user.id,
          email: data.user.email
        }
      })
    } catch (error) {
      console.error('Erro no registro:', error)
      res.status(500).json({
        error: 'Erro interno do servidor',
        message: error.message
      })
    }
  },

  /**
   * Faz login e retorna o token
   */
  async login(req, res) {
    try {
      const { email, password } = req.body

      if (!email || !password) {
        return res.status(400).json({
          error: 'Email e senha são obrigatórios'
        })
      }

      const { data, error } = await supabaseAdmin.auth.signInWithPassword({
        email,
        password
      })

      if (error) {
        return res.status(401).json({
          error: 'Credenciais inválidas',
          message: error.message
        })
      }

      res.json({
        message: 'Login realizado com sucesso',
        user: {
          id: data.user.id,
          email: data.user.email,
          metadata: data.user.user_metadata
        },
        session: {
          access_token: data.session.access_token,
          refresh_token: data.session.refresh_token,
          expires_at: data.session.expires_at
        }
      })
    } catch (error) {
      console.error('Erro no login:', error)
      res.status(500).json({
        error: 'Erro interno do servidor',
        message: error.message
      })
    }
  },

  /**
   * Atualiza o token de acesso
   */
  async refreshToken(req, res) {
    try {
      const { refresh_token } = req.body

      if (!refresh_token) {
        return res.status(400).json({
          error: 'Refresh token é obrigatório'
        })
      }

      const { data, error } = await supabaseAdmin.auth.refreshSession({
        refresh_token
      })

      if (error) {
        return res.status(401).json({
          error: 'Token inválido',
          message: error.message
        })
      }

      res.json({
        message: 'Token atualizado com sucesso',
        session: {
          access_token: data.session.access_token,
          refresh_token: data.session.refresh_token,
          expires_at: data.session.expires_at
        }
      })
    } catch (error) {
      console.error('Erro ao atualizar token:', error)
      res.status(500).json({
        error: 'Erro interno do servidor',
        message: error.message
      })
    }
  },

  /**
   * Faz logout
   */
  async logout(req, res) {
    try {
      const authHeader = req.headers.authorization
      const token = authHeader?.substring(7)

      if (token) {
        await supabaseAdmin.auth.admin.signOut(token)
      }

      res.json({
        message: 'Logout realizado com sucesso'
      })
    } catch (error) {
      console.error('Erro no logout:', error)
      res.status(500).json({
        error: 'Erro interno do servidor',
        message: error.message
      })
    }
  },

  /**
   * Retorna informações do usuário autenticado
   */
  async me(req, res) {
    try {
      res.json({
        user: {
          id: req.user.id,
          email: req.user.email,
          metadata: req.user.user_metadata,
          created_at: req.user.created_at
        }
      })
    } catch (error) {
      console.error('Erro ao buscar usuário:', error)
      res.status(500).json({
        error: 'Erro interno do servidor',
        message: error.message
      })
    }
  }
}



