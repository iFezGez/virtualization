#!/bin/bash
# enable_https.sh
# Self-signed HTTPS setup for Portainer (optional)

mkdir -p /certs
openssl req -x509 -newkey rsa:4096 -sha256 -days 365 -nodes \
  -keyout /certs/portainer.key -out /certs/portainer.crt \
  -subj "/CN=portainer.local"

docker stop portainer
docker rm portainer

docker run -d \
  -p 8000:8000 -p 9443:9443 \
  --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  -v /certs:/certs \
  -e SSL_CERT=/certs/portainer.crt \
  -e SSL_KEY=/certs/portainer.key \
  portainer/portainer-ce:2.20.2
