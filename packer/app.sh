#!/bin/bash

sleep 30


sudo yum update -y
sudo yum install -y gcc-c++ make awslogs
curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash -

# replace log group name - line 127
sudo sed -i '127s/.*/log_group_name = social-something-app/' /etc/awslogs/awslogs.conf
sudo systemctl start awslogsd
sudo systemctl enable awslogsd.service

# Pinned nodejs to 14.17 as I was consistently getting this error:
# https://github.com/nodesource/distributions/issues/1290
sudo yum install -y nodejs-14.17.1-1nodesource

sudo yum install unzip -y
cd ~/ && unzip social_something_full-master.zip
cd ~/social_something_full-master && npm i --only=prod

sudo mv /tmp/socialsomething.service /etc/systemd/system/socialsomething.service
sudo systemctl start socialsomething.service
sudo systemctl enable socialsomething.service