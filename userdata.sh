#!/bin/bash

### Launch Apache2 ###
sudo apt update
sudo apt install apache2 -y
sudo systemctl status apache2

### Change Ownership permission
sudo chown -R $USER:$USER /var/www

### Fetch public IP using instance metadata
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

### Update index.html file with public IP
echo "<html><body><h1>My Public IP Address is: $PUBLIC_IP</h1></body></html>" > /var/www/html/index.html
