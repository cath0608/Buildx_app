# syntax=docker/dockerfile:1.4

# -------- STAGE 1: Build Stage --------
FROM node:18-alpine AS builder

WORKDIR /app

# Only install dependencies
COPY package.json .
RUN npm install

# Copy all source files
COPY . .

# -------- STAGE 2: Production Image --------
FROM node:18-alpine AS production

WORKDIR /app

# Copy only necessary files from builder stage
COPY --from=builder /app .

# Expose app port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
