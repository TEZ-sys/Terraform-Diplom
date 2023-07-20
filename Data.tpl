#!/bin/sh
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//')
INSTANCE_PRIVATE_IP=$(curl http://169.254.169.254/latest/meta-data/hostname | cut -d '.' -f1)

$myip=$(ip addr show | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')


sudo su

sudo apt-get update

#sudo apt-get install nginx -y
sudo apt-get install apache2 -y
sudo ufw allow "Apache Full"
sudo a2enmod ssl
sudo systemctl restart apache2

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
echo "UA
Example
Example
Example
Example
$myip
sudo touch /etc/apache2/sites-available/$myip.conf
echo "<VirtualHost *:443>
   ServerName $myip
   DocumentRoot /var/www/$myip

   SSLEngine on
   SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
   SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</VirtualHost>" >> /etc/apache2/sites-available/$myip.conf

sudo mkdir /var/www/$myip

echo "<h1>Right now you are in a region: $REGION</h1>
<h2>The private ip of this instance: $INSTANCE_PRIVATE_IP<h2>" > /var/www/html/index.html


sudo a2ensite $myip.conf
sudo apache2ctl configtest
sudo systemctl reload apache2

sudo touch /etc/apache2/sites-available/$myip.conf

echo "<VirtualHost *:80>
	ServerName $myip
	Redirect / https://$myip/
</VirtualHost>" >> /etc/apache2/sites-available/$myip.conf

sudo apachectl configtest
sudo systemctl reload apache2

sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
