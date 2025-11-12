import { supabaseAdmin } from '../config/supabase.js'

/**
 * Controller de usuários
 */
export const userController = {
  /**
   * Lista todos os usuários (apenas admin)
   */
  async list(req, res) {
    try {
      const { page = 1, limit = 10 } = req.query
      const offset = (page - 1) * limit

      const { data, error, count } = await supabaseAdmin.auth.admin.listUsers({
        page: parseInt(page),
        perPage: parseInt(limit)
      })

      if (error) {
        return res.status(400).json({
          error: 'Erro ao listar usuários',
          message: error.message
        })
      }

      res.json({
        users: data.users.map(user => ({
          id: user.id,
          email: user.email,
          metadata: user.user_metadata,
          created_at: user.created_at,
          last_sign_in_at: user.last_sign_in_at
        })),
        pagination: {
          page: parseInt(page),
          limit: parseInt(limit),
          total: count || data.users.length
        }
      })
    } catch (error) {
      console.error('Erro ao listar usuários:', error)
      res.status(500).json({
        error: 'Erro interno do servidor',
        message: error.message
      })
    }
  },

  /**
   * Busca um usuário por ID
   */
  async getById(req, res) {
    try {
      const { id } = req.params

      const { data, error } = await supabaseAdmin.auth.admin.getUserById(id)

      if (error) {
        return res.status(404).json({
          error: 'Usuário não encontrado',
          message: error.message
        })
      }

      res.json({
        user: {
          id: data.user.id,
          email: data.user.email,
          metadata: data.user.user_metadata,
          created_at: data.user.created_at,
          last_sign_in_at: data.user.last_sign_in_at
        }
      })
    } catch (error) {
      console.error('Erro ao buscar usuário:', error)
      res.status(500).json({
        error: 'Erro interno do servidor',
        message: error.message
      })
    }
  },

  /**
   * Atualiza um usuário
   */
  async update(req, res) {
    try {
      const { id } = req.params
      const { email, password, metadata } = req.body

      const updateData = {}
      if (email) updateData.email = email
      if (password) updateData.password = password
      if (metadata) updateData.user_metadata = metadata

      const { data, error } = await supabaseAdmin.auth.admin.updateUserById(
        id,
        updateData
      )

      if (error) {
        return res.status(400).json({
          error: 'Erro ao atualizar usuário',
          message: error.message
        })
      }

      res.json({
        message: 'Usuário atualizado com sucesso',
        user: {
          id: data.user.id,
          email: data.user.email,
          metadata: data.user.user_metadata
        }
      })
    } catch (error) {
      console.error('Erro ao atualizar usuário:', error)
      res.status(500).json({
        error: 'Erro interno do servidor',
        message: error.message
      })
    }
  },

  /**
   * Deleta um usuário
   */
  async delete(req, res) {
    try {
      const { id } = req.params

      const { error } = await supabaseAdmin.auth.admin.deleteUser(id)

      if (error) {
        return res.status(400).json({
          error: 'Erro ao deletar usuário',
          message: error.message
        })
      }

      res.json({
        message: 'Usuário deletado com sucesso'
      })
    } catch (error) {
      console.error('Erro ao deletar usuário:', error)
      res.status(500).json({
        error: 'Erro interno do servidor',
        message: error.message
      })
    }
  }
}


