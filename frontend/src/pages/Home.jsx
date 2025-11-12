import { Link } from 'react-router-dom'
import '../App.css'

function Home() {
  return (
    <div style={{ minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
      <div className="card" style={{ maxWidth: '500px', textAlign: 'center' }}>
        <h1 style={{ marginBottom: '1rem', fontSize: '2.5rem', color: 'var(--primary-color)' }}>
          SAS
        </h1>
        <p style={{ marginBottom: '2rem', color: 'var(--text-secondary)', fontSize: '1.125rem' }}>
          Sistema de Gestão
        </p>
        <div style={{ display: 'flex', gap: '1rem', justifyContent: 'center' }}>
          <Link to="/login" className="btn btn-primary">
            Entrar
          </Link>
          <Link to="/dashboard" className="btn btn-secondary">
            Dashboard
          </Link>
        </div>
      </div>
    </div>
  )
}

export default Home




