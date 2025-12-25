import { useState } from 'react'
import axios from 'axios'

function Login({ setUsername, setLoggedIn }) {
  const [inputUsername, setInputUsername] = useState('')

  const handleSubmit = async (e) => {
    e.preventDefault()
    if (inputUsername.trim()) {
      const res = await axios.post(`${window.BACKEND_URL || 'http://localhost:5000'}/login`, { username: inputUsername })
      if (res.data.success) {
        setUsername(inputUsername)
        setLoggedIn(true)
      }
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
      <h1 style={{ color: '#25D366', marginBottom: '20px' }}>Sudhanshu Chat</h1>
      <h2 style={{ marginBottom: '20px' }}>Login</h2>
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
            width: '200px' 
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
          cursor: 'pointer' 
        }}>Login</button>
      </form>
    </div>
  )
}

export default Login