#!/bin/bash

cd /home/ubuntu/app
sudo npm install
sudo chown -R 1000:1000 "/home/ubuntu/.npm"
pm2 start app.js
node seeds/seed.js
npm start
