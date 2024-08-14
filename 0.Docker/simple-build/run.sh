
. setup.rc

set -x
docker run -p $PORT:80 --name $NAME --rm -d $IMAGE
set +x

