import { createClient } from '@supabase/supabase-js'
import dotenv from 'dotenv'

dotenv.config()

const supabaseUrl = process.env.SUPABASE_URL
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY

if (!supabaseUrl || !supabaseServiceKey) {
  throw new Error('Variáveis de ambiente do Supabase não configuradas')
}

// Cliente com service role key (para operações administrativas)
export const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
})

// Cliente público (para validações)
export const supabasePublic = createClient(
  supabaseUrl,
  process.env.SUPABASE_ANON_KEY || ''
)

export default supabaseAdmin



