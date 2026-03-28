#!/bin/bash
dnf install -y nginx
systemctl start nginx
systemctl enable nginx
echo "<h1>This is from ${instance_name}<h1>" > /usr/share/nginx/html/index.html
