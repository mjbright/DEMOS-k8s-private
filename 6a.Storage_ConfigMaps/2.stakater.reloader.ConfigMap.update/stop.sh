kubectl delete deploy test-cm; kubectl delete cm cm1

while kubectl get pods -l app=test-cm | grep Terminating; do
sleep 2;
done
