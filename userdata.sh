#!/bin/bash

### Launch Apache2 ###
sudo apt update
sudo apt install apache2 -y
sudo systemctl status apache2

### Fetch public IP using instance metadata
PUBLIC_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

### Update index.html file with public IP
sed -i "s/<PUBLIC_IP>/$PUBLIC_IP/g" /var/www/html/index.html
