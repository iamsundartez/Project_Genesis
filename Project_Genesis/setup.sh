#!/bin/bash

# Genesis Local Environment Setup Script

echo "=========================================="
echo " Starting Project Genesis Setup..."
echo "=========================================="

# 1. Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "[ERROR] Docker is not installed or not in your PATH."
    echo "Please install Docker Desktop: https://www.docker.com/products/docker-desktop"
    exit 1
fi

# 2. Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null; then
    # Some newer docker versions use 'docker compose' instead of 'docker-compose'
    if ! docker compose version &> /dev/null; then
        echo "[ERROR] Docker Compose is not installed."
        exit 1
    else
        COMPOSE_CMD="docker compose"
    fi
else
    COMPOSE_CMD="docker-compose"
fi

echo "[SUCCESS] Docker is installed. Initializing container..."

# 3. Build and run the docker container in detached mode
$COMPOSE_CMD up -d --build

# 4. Final Status check
if [ $? -eq 0 ]; then
    echo "=========================================="
    echo "[SUCCESS] Project Genesis is successfully running!"
    echo "🌐 Access the application at: http://localhost:8080"
    echo "=========================================="
    echo "Note: You can edit the HTML/CSS/JS files locally and just refresh your browser to see changes."
else
    echo "[ERROR] Something went wrong starting the Docker container."
fi
