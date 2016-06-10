#!/bin/sh

export NODE_ENV=production

## Certbot
wget https://dl.eff.org/certbot-auto
chmod a+x certbot-auto
./certbot-auto certonly --agree-tos --non-interactive --quiet --standalone --email j.m.clerck@icloud.com -d jclerck.io -d www.jclerck.io -d jclerck.co.uk -d www.jclerck.co.uk

## Diffie Hellman params
openssl dhparam -out dhparams.pem 4096

## Docker prereqs
apt-get update && sudo apt-get install -y apt-transport-https ca-certificates

## Docker reop
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo deb https://apt.dockerproject.org/repo ubuntu-xenial main > /etc/apt/sources.list.d/docker.list

## Docker
apt-get update && apt-get -y install docker-engine
service docker start
systemctl enable docker

## Docker-compose
curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

## Docker completion
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose

## Containers
docker-compose up nginx
