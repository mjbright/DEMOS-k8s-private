
. setup.rc

ARCH=linux/arm64
ARCH=linux/amd64

set -x
docker buildx build -t $IMAGE . --platform $ARCH
set +x

