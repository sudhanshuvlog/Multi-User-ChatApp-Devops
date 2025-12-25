import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',
    port: 3000
  },
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: './src/test/setup.js',
    coverage: {
      reporter: ['lcov', 'text', 'clover'],
      exclude: [
        'node_modules/',
        'src/test/',
        '**/*.test.jsx',
        '**/*.config.*'
      ]
    }
  },
})