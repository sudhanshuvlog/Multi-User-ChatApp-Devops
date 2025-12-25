import { useState } from 'react'
import axios from 'axios'

function Login({ setUsername, setLoggedIn }) {
  const [inputUsername, setInputUsername] = useState('')
  const [password, setPassword] = useState('')
  const [isRegister, setIsRegister] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState('')

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    setSuccess('')
    if (!inputUsername.trim() || !password.trim()) {
      setError('Please fill in all fields')
      return
    }

    try {
      const endpoint = isRegister ? '/register' : '/login'
      const res = await axios.post(`${window.BACKEND_URL || 'http://localhost:5000'}${endpoint}`, { 
        username: inputUsername, 
        password 
      })
      
      if (res.data.success) {
        if (!isRegister) {
          // Login successful
          setUsername(inputUsername)
          setLoggedIn(true)
        } else {
          // Registration successful, switch to login
          setSuccess('Registration successful! Please login.')
          setIsRegister(false)
          setPassword('')
        }
      } else {
        setError(res.data.message || 'An error occurred')
      }
    } catch (err) {
      setError(err.response?.data?.message || 'Network error')
    }
  }

  return (
    <div style={{ 
      backgroundColor: '#000', 
      color: '#fff', 
      height: '100vh', 
      display: 'flex', 
      flexDirection: 'column', 
      justifyContent: 'center', 
      alignItems: 'center', 
      fontFamily: 'Arial, sans-serif' 
    }}>
      <h1 style={{ color: '#25D366', marginBottom: '20px' }}>Sudhanshu Chat Group</h1>
      <h2 style={{ marginBottom: '20px' }}>{isRegister ? 'Register' : 'Login'}</h2>
      {error && <p style={{ color: 'red', marginBottom: '10px' }}>{error}</p>}
      {success && <p style={{ color: '#25D366', marginBottom: '10px' }}>{success}</p>}
      <form onSubmit={handleSubmit} style={{ textAlign: 'center' }}>
        <input
          type="text"
          placeholder="Enter username"
          value={inputUsername}
          onChange={(e) => setInputUsername(e.target.value)}
          style={{ 
            padding: '10px', 
            fontSize: '16px', 
            borderRadius: '5px', 
            border: 'none', 
            marginBottom: '10px', 
            width: '200px',
            display: 'block',
            margin: '0 auto 10px auto'
          }}
        />
        <input
          type="password"
          placeholder="Enter password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          style={{ 
            padding: '10px', 
            fontSize: '16px', 
            borderRadius: '5px', 
            border: 'none', 
            marginBottom: '10px', 
            width: '200px',
            display: 'block',
            margin: '0 auto 10px auto'
          }}
        />
        <br />
        <button type="submit" style={{ 
          padding: '10px 20px', 
          fontSize: '16px', 
          backgroundColor: '#25D366', 
          color: '#fff', 
          border: 'none', 
          borderRadius: '5px', 
          cursor: 'pointer',
          marginBottom: '10px'
        }}>{isRegister ? 'Register' : 'Login'}</button>
      </form>
      <button 
        onClick={() => {
          setIsRegister(!isRegister)
          setError('')
          setSuccess('')
        }}
        style={{ 
          padding: '5px 10px', 
          fontSize: '14px', 
          backgroundColor: 'transparent', 
          color: '#25D366', 
          border: '1px solid #25D366', 
          borderRadius: '5px', 
          cursor: 'pointer' 
        }}
      >
        {isRegister ? 'Already have an account? Login' : 'New user? Register'}
      </button>
    </div>
  )
}

export default Login