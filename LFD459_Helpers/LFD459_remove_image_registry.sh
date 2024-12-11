#!/usr/bin/env bash

# Run this script to
# - uninstall the easyregistry
# - remove registry endpoint from containerd config, then restart

echo; echo "== Removing easyregistry resources:"
kubectl delete -f ~/LFD459/SOLUTIONS/s_03/easyregistry.yaml

grep -q 10.97.40.62 /etc/containerd/config.toml && {
    echo; echo "== Removing easyregistry endpoint entry from containerd config.toml:"
    sudo sed -i.bak '/^endpoint = .*10.97.40.62/d' /etc/containerd/config.toml
}

echo; echo "== Restarting containerd:"
sudo systemctl restart containerd
sleep 2
sudo systemctl status containerd --no-pager

