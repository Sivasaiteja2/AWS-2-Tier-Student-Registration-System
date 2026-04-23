#!/bin/bash
set -e

# 1. Set variables globally (This makes them survive reboots)
echo "DB_HOST=${db_host}" | sudo tee -a /etc/environment
echo "DB_NAME=${db_name}" | sudo tee -a /etc/environment
echo "DB_USER=${db_user}" | sudo tee -a /etc/environment
echo "DB_PASSWORD=${db_pass}" | sudo tee -a /etc/environment

# 2. Export them for this specific execution session
export DB_HOST=${db_host}
export DB_NAME=${db_name}
export DB_USER=${db_user}
export DB_PASSWORD=${db_pass}

# System Update
sudo apt update -y
sudo apt install -y python3 python3-pip python3-venv git
sudo apt install -y python3-venv python3-pip

cd /home/ubuntu
git clone https://github.com/Sivasaiteja2/AWS-2-Tier-Student-Registration-System
cd AWS-2-Tier-Student-Registration-System
cd student-app

sudo apt update
sudo apt install -y python3.12-venv python3-pip

python3 --version

rm -rf venv
python3 -m venv venv

. venv/bin/activate

pip install --upgrade pip
pip install -r requirements.txt

pkill gunicorn || true

nohup gunicorn -w 2 -b 0.0.0.0:5000 app > app.log 2>&1 &
