#!/bin/bash
set -e

# Update packages
sudo apt update -y

# Install required packages
sudo apt install -y python3 python3-pip python3.12-venv git

apt install docker.io -y

# Export DB variables
echo "DB_HOST=${db_host}" | sudo tee -a /etc/environment
echo "DB_NAME=${db_name}" | sudo tee -a /etc/environment
echo "DB_USER=${db_user}" | sudo tee -a /etc/environment
echo "DB_PASSWORD=${db_pass}" | sudo tee -a /etc/environment

export DB_HOST=${db_host}
export DB_NAME=${db_name}
export DB_USER=${db_user}
export DB_PASSWORD=${db_pass}

# Go project folder
cd /home/ubuntu

# Clone if not exists
if [ ! -d AWS-2-Tier-Student-Registration-System ]; then
    git clone https://github.com/Sivasaiteja2/AWS-2-Tier-Student-Registration-System
fi

cd AWS-2-Tier-Student-Registration-System/student-app

docker build -t my-img .
docker run --name con1 -p 5000:5000 my-img

# Remove old venv
# rm -rf venv

# # Create new virtual env
# python3 -m venv venv

# # Activate
# source venv/bin/activate

# # Install dependencies
# pip3 install --upgrade pip
# # pip install -r requirements.txt

# pip3 install -r requirements.txt


# # Kill old gunicorn
# pkill gunicorn || true

# # Start app
# nohup gunicorn -w 2 -b 0.0.0.0:5000 app:app > app.log 2>&1 &
