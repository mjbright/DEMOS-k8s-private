

curl -sL run.linkerd.io/install-edge | sh
export PATH=$PATH:/home/student/.linkerd2/bin
echo "export PATH=$PATH:/home/student/.linkerd2/bin" >> $HOME/.bashrc
linkerd check --pre
linkerd install --crds | kubectl apply -f -
linkerd install | kubectl apply -f -
linkerd check
linkerd viz install | kubectl apply -f -
linkerd viz check

read -p "Abouit to start linkerd dashboard"
linkerd viz dashboard &

