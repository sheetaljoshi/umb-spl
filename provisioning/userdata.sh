#!/bin/bash
apt-get update -y
apt-get upgrade -y
apt-get install nginx -y
cat <<EOT > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to Cisco SPL!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Cisco SPL!</h1>
<p><em>Thank you for using Cisco SPL, if you have any questions please contact spl@cisco.com.</em></p>
</body>
</html>
EOT
systemctl restart nginx
