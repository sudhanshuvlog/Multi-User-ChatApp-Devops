FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci && npm cache clean --force
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
RUN addgroup -g 1001 -S nginx && adduser -S nginx -u 1001 -G nginx
USER nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]