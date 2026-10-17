#!/usr/bin/env bash
# ==============================================================================
# A K Construction - AWS EC2 Automated Deployment Script
# Supports: Amazon Linux 2023 / Amazon Linux 2 / Ubuntu 22.04+
# ==============================================================================

set -e

APP_DIR="/opt/ak-construction"
JAR_NAME="ak-construction-1.0.0.jar"
SERVICE_NAME="ak-construction.service"

echo "============================================="
echo "   A K Construction - EC2 Deployment Script  "
echo "============================================="

# 1. Detect OS and install prerequisites
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Unsupported OS"
    exit 1
fi

echo "[1/6] Installing dependencies for $OS..."
if [ "$OS" = "amzn" ]; then
    sudo dnf update -y || sudo yum update -y
    sudo dnf install -y java-17-amazon-corretto-headless nginx git || sudo yum install -y java-17-amazon-corretto-headless nginx git
    APP_USER="ec2-user"
elif [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
    sudo apt-get update -y
    sudo apt-get install -y openjdk-17-jre-headless nginx git curl
    APP_USER="ubuntu"
else
    echo "Unknown OS: $OS. Using default settings."
    APP_USER=$(whoami)
fi

# 2. Setup Application Directory
echo "[2/6] Setting up application directory at $APP_DIR..."
sudo mkdir -p "$APP_DIR"

if [ -f "$JAR_NAME" ]; then
    sudo cp "$JAR_NAME" "$APP_DIR/$JAR_NAME"
elif [ -f "target/$JAR_NAME" ]; then
    sudo cp "target/$JAR_NAME" "$APP_DIR/$JAR_NAME"
else
    echo "JAR file not found in current directory or target/. Please build or upload $JAR_NAME first."
fi

# 3. Configure Systemd Service
echo "[3/6] Setting up systemd service..."
sudo sed -i "s/User=ec2-user/User=$APP_USER/g" "$SERVICE_NAME" || true
sudo cp "$SERVICE_NAME" "/etc/systemd/system/$SERVICE_NAME"
sudo systemctl daemon-reload
sudo systemctl enable "$SERVICE_NAME"

# 4. Configure Nginx Reverse Proxy
echo "[4/6] Configuring Nginx reverse proxy on port 80..."
NGINX_CONF="/etc/nginx/conf.d/ak-construction.conf"
if [ ! -d "/etc/nginx/conf.d" ]; then
    sudo mkdir -p /etc/nginx/conf.d
fi

sudo bash -c "cat > $NGINX_CONF" << 'EOF'
server {
    listen 80;
    server_name _;

    client_max_body_size 50M;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF

# Test Nginx and restart
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl enable nginx

# 5. Start / Restart Spring Boot Service
echo "[5/6] Starting Spring Boot application..."
sudo systemctl restart "$SERVICE_NAME"

echo "============================================="
echo " Deployment Complete!"
echo " Service status:"
sudo systemctl status "$SERVICE_NAME" --no-pager
echo "============================================="
echo " To view live logs: journalctl -u $SERVICE_NAME -f"
