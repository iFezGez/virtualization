#!/bin/bash
# setup_stack_example.sh
# Deploy a sample Docker Compose stack via CLI

mkdir -p ~/stacks/hello-world
cd ~/stacks/hello-world

cat <<EOF > docker-compose.yml
version: "3.8"
services:
  web:
    image: nginx
    ports:
      - "8080:80"
EOF

docker compose -f docker-compose.yml up -d
