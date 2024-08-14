
To do when demoing services:

tmux multi-pane

In one pane: commands to scale up/down Service
In one pane: sudo watch -n 1 'kubectl get ep web'
In one pane: sudo watch -n 1 'iptables-save | grep web' # Possibly with: | grep -v default/' 
In one pane: ./k1s.py

