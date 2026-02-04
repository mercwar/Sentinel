# Fix the missing Yarn key and install core tools
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 62D54FD4003F6525
sudo apt-get update || true
sudo apt-get install -y nasm binutils gcc
