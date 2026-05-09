
echo
echo
echo "Installing docker..."

sudo apt-get update -y
curl -fsSL https://get.docker.com -o get-docker.sh > /dev/null 2>&1
sudo sh ./get-docker.sh  > /dev/null 2>&1
sudo gpasswd -a ubuntu docker > /dev/null 2>&1
sudo gpasswd -a jenkins docker > /dev/null 2>&1
echo "Docker installed sucessfully"
newgrp docker
docker search ubuntu
echo "If you see any permission denied error, please close the terminal and reopen it to get the updated docker group permission"
