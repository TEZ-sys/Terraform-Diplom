#!/bin/sh

sudo apt-get update

git clone https://github.com/KarpaNazarii/BlogTestApp.git
cd BlogTestApp

sudo apt-get install nginx -y
sudo apt-get install nodejs -y
sudo apt-get install npm -y

sudo npm install
sudo npx serve -y
sudo ufw allow 3000/tcp
sudo ufw allow 80/tcp

sudo npm starts