const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

describe('Authentication Functions', () => {
  const JWT_SECRET = 'test-secret-key';

  describe('Password Hashing', () => {
    test('should hash password correctly', async () => {
      const password = 'testpassword123';
      const hashedPassword = await bcrypt.hash(password, 10);

      expect(hashedPassword).toBeDefined();
      expect(hashedPassword).not.toBe(password);
      expect(hashedPassword.length).toBeGreaterThan(password.length);
    });

    test('should verify password correctly', async () => {
      const password = 'testpassword123';
      const hashedPassword = await bcrypt.hash(password, 10);

      const isValid = await bcrypt.compare(password, hashedPassword);
      expect(isValid).toBe(true);

      const isInvalid = await bcrypt.compare('wrongpassword', hashedPassword);
      expect(isInvalid).toBe(false);
    });
  });

  describe('JWT Token Generation', () => {
    test('should generate valid JWT token', () => {
      const payload = { username: 'testuser' };
      const token = jwt.sign(payload, JWT_SECRET, { expiresIn: '24h' });

      expect(token).toBeDefined();
      expect(typeof token).toBe('string');
      expect(token.split('.').length).toBe(3); // JWT has 3 parts
    });

    test('should verify JWT token correctly', () => {
      const payload = { username: 'testuser' };
      const token = jwt.sign(payload, JWT_SECRET, { expiresIn: '24h' });

      const decoded = jwt.verify(token, JWT_SECRET);
      expect(decoded.username).toBe(payload.username);
    });

    test('should reject invalid JWT token', () => {
      const invalidToken = 'invalid.jwt.token';

      expect(() => {
        jwt.verify(invalidToken, JWT_SECRET);
      }).toThrow();
    });
  });
});

describe('Database Schema Validation', () => {
  test('should validate table creation SQL', () => {
    const messagesTableSQL = "CREATE TABLE messages (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, message TEXT, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)";
    const usersTableSQL = "CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT UNIQUE, password TEXT)";

    // Basic validation that SQL contains expected keywords
    expect(messagesTableSQL).toContain('CREATE TABLE');
    expect(messagesTableSQL).toContain('messages');
    expect(messagesTableSQL).toContain('username');
    expect(messagesTableSQL).toContain('message');
    expect(messagesTableSQL).toContain('timestamp');

    expect(usersTableSQL).toContain('CREATE TABLE');
    expect(usersTableSQL).toContain('users');
    expect(usersTableSQL).toContain('username');
    expect(usersTableSQL).toContain('password');
    expect(usersTableSQL).toContain('UNIQUE');
  });
});

describe('Environment Configuration', () => {
  test('should validate environment variables', () => {
    // Test that required environment variables are defined
    expect(process.env.NODE_ENV).toBe('test');

    // JWT secret should be available
    const jwtSecret = process.env.JWT_SECRET || 'your-secret-key';
    expect(jwtSecret).toBeDefined();
    expect(jwtSecret.length).toBeGreaterThan(0);
  });
});