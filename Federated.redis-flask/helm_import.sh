#!/usr/bin/env bash

# kubectl apply -f v0.4_helm_import/

# ~/scripts/install_helm.sh 

set -x

rm -rf v0.5_helm_imported

helm list | grep ^flask-redis && helm uninstall flask-redis

helm create flask-redis
rm -fr flask-redis/templates/*.yaml

helm list -A

cp -a v0.4_helm_import/* flask-redis/templates/

cat > flask-redis/Chart.yaml <<EOF

apiVersion: v2
name: flask-redis
description: A Helm chart for flask-redis
type: application

# This is the chart version.
version: 0.1.0

# This is the version number of the application being deployed. This version number should be
# incremented each time you make changes to the application. Versions are not expected to
# follow Semantic Versioning. They should reflect the version the application is using.
# It is recommended to use it with quotes.
appVersion: "0.4.1"

EOF

helm upgrade --install --force flask-redis ./flask-redis/
helm list -A

mkdir -p v0.5_helm_imported/

mv flask-redis v0.5_helm_imported/

