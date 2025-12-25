require('dotenv').config();

const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
const sqlite3 = require('sqlite3').verbose();
const mysql = require('mysql2/promise');
const cors = require('cors');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
  cors: {
    origin: true,
    methods: ["GET", "POST"]
  }
});

app.use(cors());
app.use(express.json());

// JWT secret
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';

// DB setup
let db;
if (process.env.USE_LOCAL_DB === 'true') {
  // Use SQLite for local
  db = new sqlite3.Database('./chat.db');
  db.serialize(() => {
    db.run("CREATE TABLE IF NOT EXISTS messages (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, message TEXT, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)", (err) => {
      if (err) console.error('Error creating messages table:', err);
      else console.log('Messages table created or already exists');
    });
    db.run("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT UNIQUE, password TEXT)", (err) => {
      if (err) console.error('Error creating users table:', err);
      else console.log('Users table created or already exists');
    });
  });
} else {
  // Use MySQL for production
  if (!process.env.DATABASE_URL) {
    console.error('DATABASE_URL environment variable is not set');
    process.exit(1);
  }
  db = mysql.createPool(process.env.DATABASE_URL);
  db.execute(`CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255),
    message TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  )`).then(() => {
    console.log('Messages table created or already exists');
  }).catch(err => console.error('Error creating messages table:', err));
  db.execute(`CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE,
    password VARCHAR(255)
  )`).then(() => {
    console.log('Users table created or already exists');
  }).catch(err => console.error('Error creating users table:', err));
}

// Routes
app.post('/register', async (req, res) => {
  console.log('Register request:', req.body);
  const { username, password } = req.body;
  if (!username || !password) {
    return res.status(400).json({ success: false, message: 'Username and password required' });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    if (process.env.USE_LOCAL_DB === 'true') {
      db.run("INSERT INTO users (username, password) VALUES (?, ?)", [username, hashedPassword], function(err) {
        if (err) {
          console.log('DB error:', err);
          if (err.code === 'SQLITE_CONSTRAINT_UNIQUE') {
            return res.status(400).json({ success: false, message: 'Username already exists' });
          }
          return res.status(500).json({ success: false, message: 'Database error' });
        }
        console.log('User registered:', username);
        res.json({ success: true, message: 'User registered successfully' });
      });
    } else {
      await db.execute('INSERT INTO users (username, password) VALUES (?, ?)', [username, hashedPassword]);
      res.json({ success: true, message: 'User registered successfully' });
    }
  } catch (error) {
    console.log('Register error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
});

app.post('/login', async (req, res) => {
  console.log('Login request:', req.body);
  const { username, password } = req.body;
  if (!username || !password) {
    return res.status(400).json({ success: false, message: 'Username and password required' });
  }

  try {
    let user;
    if (process.env.USE_LOCAL_DB === 'true') {
      user = await new Promise((resolve, reject) => {
        db.get("SELECT * FROM users WHERE username = ?", [username], (err, row) => {
          if (err) reject(err);
          else resolve(row);
        });
      });
    } else {
      const [rows] = await db.execute('SELECT * FROM users WHERE username = ?', [username]);
      user = rows[0];
    }

    console.log('User found:', user ? 'yes' : 'no');
    if (!user) {
      return res.status(400).json({ success: false, message: 'User not found' });
    }

    const isValidPassword = await bcrypt.compare(password, user.password);
    console.log('Password valid:', isValidPassword);
    if (!isValidPassword) {
      return res.status(400).json({ success: false, message: 'Invalid password' });
    }

    const token = jwt.sign({ username }, JWT_SECRET, { expiresIn: '24h' });
    console.log('Login successful for:', username);
    res.json({ success: true, token, username });
  } catch (error) {
    console.log('Login error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
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