#! /bin/bash
maindir='/home/eremite/nginxhls'
docker image build -t eremite/nginxhls "${maindir}/docker/"
docker stop nginxhls
docker container rm nginxhls
docker system prune -f
docker container run -d -v "/home/eremite/nginxhls/hls/:/mnt/hls" -v "/var/log/nginxhls/:/var/log/nginxhls/" -p 8080:8080 -p 1935:1935 --restart no --name nginxhls eremite/nginxhls:latest
