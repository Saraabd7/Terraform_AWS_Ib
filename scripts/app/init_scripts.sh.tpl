#!/bin/bash
echo "${my_name}"
cd /home/ubuntu/app
sudo npm install
export DB_HOST=mongodb://${db-ip}:27017/posts
sudo chown -R 1000:1000 "/home/ubuntu/.npm"
pm2 start app.js
node seeds/seed.js
npm start
