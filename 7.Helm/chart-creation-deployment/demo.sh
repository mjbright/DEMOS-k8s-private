#!/usr/bin/env bash

# Adapted from lab at: https://jruels.github.io/az-core-k8s/labs/helm/

# TODO: extend scenario? (as above lab) => rollback, then history

cd $(dirname $0)

# TODO: Use app (helm-demo) and release (demo-release) variables ...

echo "Sourcing ../../demos.rc"
source ../../demos.rc

#RELEASE=my-helm-demo
RELEASE=helm-demo

which tree || sudo apt-get install -y tree

which helm || {
    YELLOW "Installing Helm ..."
    export VERIFY_CHECKSUM=false
    RUN 'curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash'
}

SET_SVC_IP() {
    SVC=$1; shift

    export SVC_IP=$( kubectl get svc $SVC -n helm-demo -o jsonpath='{.spec.clusterIP}' )
}

CLEANUP() {
    helm -n helm-demo ls | grep helm-demo >/dev/null 2>&1 && helm -n helm-demo uninstall helm-demo
    #helm-demo uninstall -n helm-demo helm-demo >/dev/null 2>&1
    #helm -n helm-demo ls helm-demo && helm -n helm-demo uninstall helm-demo
    rm -rf demo-app/ helm-demo/
}

RUN helm version

#### #RUN helm search hub nginx-ingress
#### RUN helm search hub ingress-nginx

CREATE_INITIAL_CHART() {
    DEMO_HEADER "Create a new chart 'demo-app'"
    [ ! -d helm-demo ] && RUN helm create helm-demo

    RUN tree helm-demo
}

INSTALL_INITIAL_CHART() {
    helm ls -A | grep -q helm-demo || {
        STEP_HEADER "Install the chart into the namespace 'helm-demo':"
        RUN helm install -n helm-demo --create-namespace helm-demo ./helm-demo --set service.type=LoadBalancer
    }
    RUN helm ls -A
    RUN kubectl get pods -n helm-demo -l app.kubernetes.io/name=helm-demo
    RUN kubectl get svc -n helm-demo -l app.kubernetes.io/name=helm-demo
    SET_SVC_IP helm-demo
    RUN curl -s ${SVC_IP}:80
}

UPDATE_CHART() {
    PACKAGE_TAR=$1

    RUN helm upgrade -n helm-demo helm-demo $PACKAGE_TAR
}

DIFF() {
    echo; echo "====  diff $1 $2"
    RUN diff $1 $2 | grep -v '< #' | grep -E '^(<|>) ' | sed 's/^> /  >/'
}

PACKAGE_CHART_v020() {
    #ls -altr 
    [ ! -f helm-demo/.Chart.yaml.0 ] && cp -a helm-demo/Chart.yaml helm-demo/.Chart.yaml.0
    cat > helm-demo/Chart.yaml <<EOF
# Updated Chart version:
version: 0.2.0
description: A demo Helm chart

# Updated Application version:
appVersion: "1.17.0"

apiVersion: v2
name: helm-app
type: application
EOF
    DIFF helm-demo/.Chart.yaml.0 helm-demo/Chart.yaml

    [ ! -f helm-demo/.values.yaml.0 ] && cp -a helm-demo/values.yaml helm-demo/.values.yaml.0
    sed -i.bak helm-demo/values.yaml \
        -e 's?repository: .*?repository: aslaen/helm-demo?' \
        -e 's?tag: .*?tag: v1?' \
        -e 's?type: .*?type: LoadBalancer?' \
        -e 's?port: .*?port: 8080?' \
        -e '/livenessProbe:.*/,+7 s/^/# /'
    DIFF helm-demo/.values.yaml.0 helm-demo/values.yaml
    # https://stackoverflow.com/questions/71711415/how-to-replace-2-consecutive-lines-after-match-with-sed
    # https://unix.stackexchange.com/questions/285160/how-to-edit-next-line-after-pattern-using-sed
    #  '/Unix/{n;s/.*/hi/}'

    [ ! -f helm-demo/templates/.service.yaml.0 ] && cp -a helm-demo/templates/service.yaml helm-demo/templates/.service.yaml.0
    sed -i.bak helm-demo/templates/service.yaml \
        -e 's?targetPort: .*?targetPort: {{ .Values.service.port }}?'
    DIFF helm-demo/templates/.service.yaml.0 helm-demo/templates/service.yaml

    [ ! -f helm-demo/templates/.deployment.yaml.0 ] && cp -a helm-demo/templates/deployment.yaml helm-demo/templates/.deployment.yaml.0
    sed -i.bak helm-demo/templates/deployment.yaml \
        -e 's?livenessProbe: .*?#livenessProbe:?' \
        -e 's?readinessProbe: .*?#readinessProbe:?'
    DIFF helm-demo/templates/.deployment.yaml.0 helm-demo/templates/deployment.yaml

    RUN helm lint helm-demo

    RUN helm package helm-demo
    ls -al helm-app-0.2.0.tgz
}

CLEANUP
CREATE_INITIAL_CHART
INSTALL_INITIAL_CHART
PACKAGE_CHART_v020
UPDATE_CHART helm-app-0.2.0.tgz
SET_SVC_IP helm-demo-helm-app
RUN curl -s ${SVC_IP}:8080/hello
helm history -n helm-demo helm-demo
