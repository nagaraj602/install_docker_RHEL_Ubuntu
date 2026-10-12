#!/bin/bash
echo ""
echo "🚀 Installing Docker..."
echo ""
    
# Detect package manager & update
if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update -y > /dev/null 2>&1
    sudo apt-get install -y curl ca-certificates > /dev/null 2>&1
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y shadow-utils curl > /dev/null 2>&1
elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y curl > /dev/null 2>&1
fi
  
# Install Docker via official get.docker.com script
curl -fsSL https://get.docker.com -o get-docker.sh > /dev/null 2>&1
sudo sh ./get-docker.sh > /dev/null 2>&1
rm -f get-docker.sh
    
# Ensure Docker is enabled and actively running
sudo systemctl enable --now docker > /dev/null 2>&1
    
# Add current user and common users to docker group (if they exist)
CURRENT_USER=$(whoami)
sudo usermod -aG docker "$CURRENT_USER" 2>/dev/null || true
id -u ubuntu >/dev/null 2>&1 && sudo usermod -aG docker ubuntu 2>/dev/null || true
id -u jenkins >/dev/null 2>&1 && sudo usermod -aG docker jenkins 2>/dev/null || true

# Restart Jenkins only if Jenkins is installed
if systemctl list-unit-files | grep -q jenkins; then
  sudo systemctl restart jenkins > /dev/null 2>&1
  fi

echo "✅ Docker installed and service started successfully!"
