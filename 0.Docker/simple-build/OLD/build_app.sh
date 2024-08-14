CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags '-w' -o demo-binary main.go
docker build -t docker-demo:scratch -f Dockerfile.scratch .
