
NS=default
[ ! -z "$1" ] && NS=$1

kubectl label ns $NS environment=test

