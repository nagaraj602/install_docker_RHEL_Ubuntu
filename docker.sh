
echo
echo
echo "Installing docker..."

sudo apt-get update -y > /dev/null 2>&1
sudo yum update -y > /dev/null 2>&1
sudo apt-get install login -y > /dev/null 2>&1
sudo dnf install shadow-utils -y > /dev/null 2>&1
curl -fsSL https://get.docker.com -o get-docker.sh > /dev/null 2>&1
sudo sh ./get-docker.sh  > /dev/null 2>&1
sudo gpasswd -a ubuntu docker > /dev/null 2>&1
sudo gpasswd -a jenkins docker > /dev/null 2>&1
echo "Docker installed sucessfully"

sudo usermod -aG docker ubuntu > /dev/null 2>&1
sudo usermod -aG docker jenkins > /dev/null 2>&1
sudo usermod -aG docker "$(whoami)"
newgrp docker

sudo systemctl restart jenkins > /dev/null 2>&1
sudo systemctl enable docker
docker search ubuntu
if [ $? -ne 0 ]; then
  echo "If you're seeing permission denied error, please close the terminal and reopen it to get the updated docker group permission"
fi
