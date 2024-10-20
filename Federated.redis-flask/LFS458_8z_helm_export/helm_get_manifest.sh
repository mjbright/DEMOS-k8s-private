#!/usr/bin/env bash

cd $( dirname $0 )/..

DIR=LFS458_8z_helm_export

mkdir -p $DIR
helm get manifest flask-redis  >  $DIR/redis-flask.yaml

ls -al $DIR/redis-flask.yaml

