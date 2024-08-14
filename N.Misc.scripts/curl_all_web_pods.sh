
# for IP in $( kubectl get pods -o custom-columns=IP:.status.podIP --no-headers ); do curl -sL $IP/1; done

kubectl get pods -o custom-columns=IP:.status.podIP --no-headers | xargs -I PODIP -t curl -sL PODIP/1

