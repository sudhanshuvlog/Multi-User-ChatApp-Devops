module.exports = {
  testEnvironment: 'node',
  testMatch: ['**/tests/**/*.test.js'],
  verbose: true,
  collectCoverageFrom: [
    'server.js',
    '!node_modules/**'
  ],
  coverageDirectory: 'coverage',
  coverageReporters: ['lcov', 'text', 'clover'],
  testResultsProcessor: 'jest-sonar-reporter'
};