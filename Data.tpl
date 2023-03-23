#!/bin/sh

sudo apt-get update

git clone https://github.com/KarpaNazarii/BlogTestApp.git
cd BlogTestApp

sudo apt-get install nodejs -y
sudo apt-get install npm -y

sudo npm install 
sudo npx serve -y
sudo ufw allow 5000/tcp

sudo npm starts
