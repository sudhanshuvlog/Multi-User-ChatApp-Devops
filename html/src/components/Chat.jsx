import { useState, useEffect, useRef } from 'react'
import io from 'socket.io-client'

function Chat({ username }) {
  const [messages, setMessages] = useState([])
  const [inputMessage, setInputMessage] = useState('')
  const [socket, setSocket] = useState(null)
  const messagesEndRef = useRef(null)

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" })
  }

  useEffect(() => {
    const newSocket = io('http://localhost:5000')
    setSocket(newSocket)

    newSocket.on('connect', () => {
      console.log('Connected to server')
    })

    newSocket.on('load messages', (msgs) => {
      console.log('Received load messages:', msgs)
      setMessages(msgs)
      scrollToBottom()
    })

    newSocket.on('new message', (msg) => {
      console.log('Received new message:', msg)
      setMessages(prev => [...prev, msg])
      scrollToBottom()
    })

    return () => {
      newSocket.off('load messages')
      newSocket.off('new message')
      newSocket.disconnect()
    }
  }, [])

  const sendMessage = () => {
    if (inputMessage.trim() && socket) {
      socket.emit('send message', { username, message: inputMessage })
      setInputMessage('')
    }
  }

  return (
    <div style={{ 
      backgroundColor: '#000', 
      color: '#fff', 
      height: '100vh', 
      display: 'flex', 
      flexDirection: 'column', 
      fontFamily: 'Arial, sans-serif' 
    }}>
      <div style={{ 
        backgroundColor: '#075E54', 
        padding: '10px', 
        textAlign: 'center', 
        fontSize: '20px', 
        fontWeight: 'bold' 
      }}>
        Sudhanshu Chat
      </div>
      <div style={{ 
        flex: 1, 
        overflowY: 'scroll', 
        padding: '10px', 
        backgroundColor: '#0A0A0A' 
      }}>
        {messages.map(msg => (
          <div key={msg.id} style={{ 
            marginBottom: '10px', 
            display: 'flex', 
            justifyContent: msg.username === username ? 'flex-end' : 'flex-start' 
          }}>
            <div style={{ 
              maxWidth: '70%', 
              padding: '8px 12px', 
              borderRadius: '10px', 
              backgroundColor: msg.username === username ? '#25D366' : '#fff', 
              color: msg.username === username ? '#fff' : '#000', 
              wordWrap: 'break-word' 
            }}>
              {msg.username !== username && <strong>{msg.username}: </strong>}
              {msg.message}
              <br />
              <small style={{ fontSize: '10px', color: msg.username === username ? '#e0e0e0' : '#666' }}>
                {new Date(msg.timestamp).toLocaleString()}
              </small>
            </div>
          </div>
        ))}
        <div ref={messagesEndRef} />
      </div>
      <div style={{ 
        padding: '10px', 
        backgroundColor: '#075E54', 
        display: 'flex' 
      }}>
        <input
          type="text"
          value={inputMessage}
          onChange={(e) => setInputMessage(e.target.value)}
          onKeyPress={(e) => e.key === 'Enter' && sendMessage()}
          style={{ 
            flex: 1, 
            padding: '10px', 
            borderRadius: '20px', 
            border: 'none', 
            marginRight: '10px' 
          }}
          placeholder="Type your message..."
        />
        <button onClick={sendMessage} style={{ 
          padding: '10px 20px', 
          backgroundColor: '#25D366', 
          color: '#fff', 
          border: 'none', 
          borderRadius: '20px', 
          cursor: 'pointer' 
        }}>Send</button>
      </div>
    </div>
  )
}

export default Chat