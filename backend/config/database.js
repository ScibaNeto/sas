import { supabaseAdmin } from './supabase.js'

/**
 * Testa a conexão com o banco de dados
 */
export const testConnection = async () => {
  try {
    const { data, error } = await supabaseAdmin
      .from('_prisma_migrations')
      .select('*')
      .limit(1)

    if (error && error.code !== 'PGRST116') {
      throw error
    }

    console.log('✅ Conexão com Supabase estabelecida')
    return true
  } catch (error) {
    console.error('❌ Erro ao conectar com Supabase:', error.message)
    return false
  }
}

export default supabaseAdmin



