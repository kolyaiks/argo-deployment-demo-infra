#!/usr/bin/env bash

#update system
yum update -y

#setting locale
localectl set-locale LANG=ru_RU.utf8

#setting TimeZone
mv /etc/localtime /etc/localtime.backup
ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime

#some stuff
yum install mc -y

#docker install
sudo yum install docker -y
systemctl enable docker
systemctl start docker

mkdir /home/projects
mkdir /home/projects/${name_of_application}_${env}

cd /home/projects/${name_of_application}_${env}

imageName=${current_aws_account}.dkr.ecr.${current_region}.amazonaws.com/${name_of_application}:0.0.6
login=$(aws ecr get-login --no-include-email --region ${current_region})
$login
docker pull $imageName

docker run --name ${name_of_application}_${env} \
-e SPRING_PROFILES_ACTIVE=${env} \
-p 443:443 \
-v /home/projects/${name_of_application}_${env}/LOGS:/app/LOGS \
--restart always \
-d $imageName