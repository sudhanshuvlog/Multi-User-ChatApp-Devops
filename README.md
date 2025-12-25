# Multi Chat Application

A real-time multi-user chat web application built with Node.js, Express, Socket.io, and React.

## Features

- User login with username
- Real-time chat with multiple users
- Messages stored in local SQLite database
- Auto-scrolling chat interface
- Containerized with Docker

## Local Development

### Prerequisites

- Node.js (v18 or higher)
- Docker and Docker Compose

### Running Locally

1. Clone the repository
2. Install dependencies for backend and frontend:

   ```bash
   cd backend
   npm install

   cd ../html
   npm install
   ```

3. Start the backend:

   ```bash
   cd backend
   npm run dev
   ```

4. Start the frontend:

   ```bash
   cd html
   npm run dev
   ```

5. Open http://localhost:3000 in your browser

### Running with Docker

1. Build and run the containers:

   ```bash
   docker-compose up --build
   ```

2. Open http://localhost:3000 in your browser

## CI/CD

- GitHub Actions for CI: Runs tests, SonarQube analysis, and pushes Docker images to DockerHub.
- Jenkins for CD: Deploys to EKS using Kubernetes manifests.

## Deployment

## Deployment

For production deployment on Kubernetes with RDS MySQL and S3, additional configuration will be needed.

- Set up RDS MySQL instance.
- In Jenkins, set up credentials for `mysql-connection-string` with the MySQL connection string.
- Jenkins will create the Kubernetes secret with DATABASE_URL.
- Set USE_LOCAL_DB=false in deployment.
- Update K8s manifests with correct image names and secrets.

For local development, USE_LOCAL_DB=true (set in backend/.env).

## Project Structure

- `backend/` - Node.js server with Socket.io
- `html/` - React application
- `k8s/` - Kubernetes deployment files
- `docker-compose.yml` - Docker Compose configuration