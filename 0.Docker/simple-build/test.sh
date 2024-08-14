
. setup.rc

if [ ! -z "$1" ]; then
    curl 127.0.0.1:$PORT/1
else
    curl 127.0.0.1:$PORT
fi


