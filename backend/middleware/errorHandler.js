/**
 * Middleware de tratamento de erros
 */
export const errorHandler = (err, req, res, next) => {
  console.error('Erro:', err)

  const statusCode = err.statusCode || 500
  const message = err.message || 'Erro interno do servidor'

  res.status(statusCode).json({
    error: message,
    ...(process.env.NODE_ENV === 'development' && { stack: err.stack })
  })
}

/**
 * Middleware para rotas não encontradas
 */
export const notFound = (req, res) => {
  res.status(404).json({
    error: 'Rota não encontrada',
    message: `A rota ${req.method} ${req.path} não existe`
  })
}




