#!/bin/bash
apt-get update -y
apt-get upgrade -y
apt-get install nginx -y
aws s3 sync --delete s3://${var.app_prefix}-assets/html /var/www/html
crontab -l ; echo '*/1 * * * * root aws s3 sync --delete s3://${var.app_prefix}-assets/html /var/www/html' ) | crontab -
#wget https://raw.githubusercontent.com/nginxinc/NGINX-Demos/master/nginx-hello/index.html --output-document /usr/share/nginx/html/index.html
#wget https://raw.githubusercontent.com/nginxinc/NGINX-Demos/master/nginx-hello/hello.conf --output-document /etc/nginx/sites-enabled/default
systemctl restart nginx
