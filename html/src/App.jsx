import { useState } from 'react'
import Login from './components/Login'
import Chat from './components/Chat'

function App() {
  const [username, setUsername] = useState('')
  const [loggedIn, setLoggedIn] = useState(false)

  return (
    <div className="App" style={{ height: '100vh' }}>
      {!loggedIn ? (
        <Login setUsername={setUsername} setLoggedIn={setLoggedIn} />
      ) : (
        <Chat username={username} />
      )}
    </div>
  )
}

export default App