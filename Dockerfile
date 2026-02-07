# Build stage
FROM node:20-alpine AS build
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install
COPY . .
RUN npm run build

# Runtime stage
FROM python:3.11-slim
WORKDIR /app
COPY --from=build /app/dist ./dist
EXPOSE 8080
CMD ["python", "-m", "http.server", "8080", "--directory", "dist"]
