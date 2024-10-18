#!/usr/bin/env bash

# kubectl apply -f $IMPORT_DIR/

which helm || ~/scripts/install_helm.sh 

die() { echo "$0: die - $*" >&2; exit 1; }

cd $( dirname $0 )/..

IMPORT_DIR=LFS458_8_helm_import
IMPORTED_DIR=LFS458_8b_helm_imported_upgrade

[ ! -d $IMPORT_DIR   ] && die "No such dir '$IMPORT_DIR'"
[ ! -d $IMPORTED_DIR ] && die "No such dir '$IMPORTED_DIR'"

set -x

helm list | grep ^flask-redis && helm uninstall flask-redis

mkdir -p    $IMPORTED_DIR
rm   -rf    $IMPORTED_DIR/flask-redis

helm create $IMPORTED_DIR/flask-redis

rm -rf      $IMPORTED_DIR/flask-redis/templates/*.yaml

cp -a $IMPORT_DIR/*.yaml $IMPORTED_DIR/flask-redis/templates/

cat > $IMPORTED_DIR/flask-redis/Chart.yaml <<EOF

apiVersion: v2
name: flask-redis
description: A Helm chart for flask-redis
type: application

# This is the chart version.
version: 0.1.0

# This is the version number of the application being deployed.
# This version number should be incremented each time you make changes to the application.
appVersion: "0.4.1"

EOF

#helm list -A
helm upgrade --install --force flask-redis ./$IMPORTED_DIR/flask-redis/
helm list -A

mkdir -p $IMPORTED_DIR

#mv flask-redis $IMPORTED_DIR

