kubectl  -n netpol-01 run --rm -i -t --image=alpine test-$RANDOM -- wget -qO - --timeout=2 http://web
