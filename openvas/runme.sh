#!/bin/bash

export DOWNLOAD_DIR=$HOME/greenbone-community-container

docker compose -f $DOWNLOAD_DIR/docker-compose.yml -p greenbone-community-edition up -d
