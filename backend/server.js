require('dotenv').config();

const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
const sqlite3 = require('sqlite3').verbose();
const mysql = require('mysql2/promise');
const cors = require('cors');

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
  cors: {
    origin: "http://localhost:3000",
    methods: ["GET", "POST"]
  }
});

app.use(cors());
app.use(express.json());

// DB setup
let db;
if (process.env.USE_LOCAL_DB === 'true') {
  // Use SQLite for local
  db = new sqlite3.Database('./chat.db');
  db.serialize(() => {
    db.run("CREATE TABLE IF NOT EXISTS messages (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, message TEXT, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)", (err) => {
      if (err) console.error('Error creating table:', err);
      else console.log('Messages table created or already exists');
    });
  });
} else {
  // Use MySQL for production
  db = mysql.createPool(process.env.DATABASE_URL);
  db.execute(`CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255),
    message TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  )`).then(() => {
    console.log('Messages table created or already exists');
  }).catch(err => console.error('Error creating table:', err));
}

// Routes
app.post('/login', (req, res) => {
  const { username } = req.body;
  if (username) {
    res.json({ success: true });
  } else {
    res.json({ success: false });
  }
});

// Socket.io
io.on('connection', (socket) => {
  console.log('User connected');

  // Send all messages
  if (process.env.USE_LOCAL_DB === 'true') {
    db.all("SELECT * FROM messages ORDER BY id", (err, rows) => {
      if (err) {
        console.error('Error loading messages:', err);
      } else {
        console.log('Loaded', rows.length, 'messages');
        socket.emit('load messages', rows);
      }
    });
  } else {
    db.execute('SELECT * FROM messages ORDER BY id').then(([rows]) => {
      console.log('Loaded', rows.length, 'messages');
      socket.emit('load messages', rows);
    }).catch(err => console.error('Error loading messages:', err));
  }

  socket.on('send message', (data) => {
    const { username, message } = data;
    console.log('Received message from', username, ':', message);
    if (process.env.USE_LOCAL_DB === 'true') {
      db.run("INSERT INTO messages (username, message) VALUES (?, ?)", [username, message], function(err) {
        if (err) {
          console.error('Insert error:', err);
        } else {
          console.log('Inserted message with id:', this.lastID);
          io.emit('new message', { id: this.lastID, username, message, timestamp: new Date() });
        }
      });
    } else {
      db.execute('INSERT INTO messages (username, message) VALUES (?, ?)', [username, message]).then(([result]) => {
        console.log('Inserted message with id:', result.insertId);
        io.emit('new message', { id: result.insertId, username, message, timestamp: new Date() });
      }).catch(err => console.error('Insert error:', err));
    }
  });

  socket.on('disconnect', () => {
    console.log('User disconnected');
  });
});

const PORT = process.env.PORT || 5000;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});