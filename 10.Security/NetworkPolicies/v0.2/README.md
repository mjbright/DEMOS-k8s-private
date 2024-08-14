    1  ll .ssh/
    2  sudo vi /etc/hosts
    3  ll
    4  ll DEMOS/
    5  ll src/
    6  #ll /etc/host
    7  ll -tr /tmp/
    8  ll -tr /tmp/files1.zip 
    9  unzip -l /tmp/files1.zip 
   10  unzip -l /tmp/files1.zip  | grep -u host
   11  unzip -l /tmp/files1.zip  | grep -u hosts
   12  ll .ssh/
   13  ll .ssh/config 
   14  more .ssh/config 
   15  cat etc_hosts.trainer.full 
   16  more etc_hosts.trainer.full 
   17  more etc_hosts.trainer.full  | sudo tee -a /etc/hosts
   18  sudo vi /etc/hosts
   19  ssh cp uptime
   20  ssh wo uptime
   21  #ssh wo uptime
   22  ll .ssh//config 
   23  cat .ssh//config 
   24  ll .ssh/
   25  ll -tr
   26  tmux 
   27  dpkg -l | grep -i crio
   28  dpkg -l | grep -i cri-o
   29  dpkg -l | grep -i cri
   30  kubectl get events -A -w
   31  kubectl get pods -A
   32  kubectl get pods -n kube-system
   33  kubectl get no
   34  vi k8scp.sh
   35  vi k8sWorker.sh 
   36  cat /etc/hosts
   37  ssh wo uptime
   38  ssh wo -i .ssh/t-key.pem uptime
   39  ll scripts/
   40  ./scripts/k8s-installer.sh
   41  #./scripts/k8s-installer.sh
   42  ll -tr scripts/
   43  vi scripts/k8s-installer.sh
   44  dpkg -l | grep crio
   45  dpkg -l | grep cri
   46  ll -tr /etc/apt/sources.list.d/
   47  ./scripts/k8s-installer.sh |& tee /tmp/k8s-installer.sh
   48  sudo rm /etc/apt/sources.list.d/*
   49  ll -tr /etc/apt/sources.list.d/
   50  ll tmp/
   51  ll 
   52  tar xf LFD459_V1.23.1-u1_SOLUTIONS.tar.xz 
   53  ll LFD459_V1.23.1-u1_SOLUTIONS.tar.xz 
   54  ll LFD459/SOLUTIONS/s_02/k8scp.sh 
   55  cp -a LFD459/SOLUTIONS/s_02/k8scp.sh  .
   56  ./k8scp.sh 
   57  history
   58  ./k8scp.sh 2>&1 >/k8scp.sh.op
   59  ./k8scp.sh 2>&1 >k8scp.sh.op
   60  vi k8scp.sh.op 
   61  vi k8scp.sh
   62  ./k8scp.sh 2>&1 >k8scp.sh.op2
   63  dpkg -l | grep cri
   64  crictl ps
   65  sudo crictl ps
   66  kubeadm version
   67  vi k8scp.sh
   68  sudo apt-mark hold kubeadm kubelet kubectl
   69  sudo apt-mark unhold kubeadm kubelet kubectl
   70  sudo apt-get remove -y kubeadm kubelet kubectl
   71  ll LFD459/SOLUTIONS/s_02/
   72  cp -a LFD459/SOLUTIONS/s_02/k8sWorker.sh .
   73  grep hold k8s*.sh
   74  grep hold k8s*.sh >> k8sWorker.sh 
   75  vi k8sWorker.sh 
   76  ./k8scp.sh 
   77  vi k8scp.sh
   78  find / -name kubeadm.yaml 2>/dev/null
   79  vi k8scp.sh
   80  ./k8scp.sh 
   81  scp k8sWorker.sh t-kube1-2:
   82  scp  -i ~/.ssh/t-key.pem k8sWorker.sh t-kube1-2:
   83  kubectl get no
   84  kubectl get po
   85  sudo apt-get install -y podman
   86  podman
   87  kubectl get no -w
   88  kubectl get po -A
   89  kubectl get nodes
   90  kubectl get pods
   91  kubectl get namespaces
   92  kubectl get pods --all-namespaces
   93  kubectl get pods
   94  kubectl run testpod --image mjbright/k8s-demo:alpine1
   95  kubectl get po
   96  kubectl get po
   97  kubectl get po
   98  kubectl get po
   99  kubectl describe pod testpod 
  100  kubectl taint node cp node-role.kubernetes.io/master-
  101  kubectl describe pod testpod 
  102  kubectl describe pod testpod 
  103  sudo crictl ps
  104  kubectl describe pod testpod  | less
  105  kubectl get po
  106  kubectl get po -o wide
  107  curl -L 192.168.242.65
  108  kubectl delete pod testpod
  109  kubectl get po
  110  kubectl run testpod --image mjbright/k8s-demo:alpine1 --dry-run=client
  111  kubectl get po k
  112  kubectl run testpod --image mjbright/k8s-demo:alpine1 --dry-run=client -o yaml
  113  kubectl run testpod --image mjbright/k8s-demo:alpine1 --dry-run=client -o yaml > testpod.yaml
  114  vi testpod.yaml 
  115  kubectl create -f testpod.yaml 
  116  kubectl get po
  117  kubectl run -v 10 testpod --image mjbright/k8s-demo:alpine1 > kubectl.run.log 2>&1
  118  kubectl get po
  119  vi kubectl.run.log 
  120  vi testpod.json
  121  kubectl create -f testpod.json
  122  kubectl get po
  123  kubectl get po -o wide
  124  curl -L 192.168.242.67/1
  125  curl -L 192.168.242.66/1
  126  curl -L 192.168.242.68/1
  127  kubectl get po --show-labels
  128  more testpod.yaml 
  129  kubectl delete pod --all
  130  kubectl get po --show-labels
  131  kubectl create deploy web --image mjbright/k8s-demo:alpine1 --replicas 3 --dry-run=client
  132  kubectl create deploy web --image mjbright/k8s-demo:alpine1 --replicas 3 --dry-run=client -o yaml
  133  kubectl create deploy web --image mjbright/k8s-demo:alpine1 --replicas 3 --dry-run=client -o yaml > deploy_web.yaml
  134  vi deploy_web.yaml 
  135  kubectl create -f deploy_web.yaml 
  136  kubectl get deploy_web.yaml 
  137  kubectl get deploy
  138  kubectl get pods
  139  kubectl delete pod web-8c498f97d-dcsnf
  140  kubectl get pods
  141  #kubectl scale deploy web --replicas 5
  142  vi deploy_web.yaml 
  143  kubectl create -f deploy_web.yaml 
  144  kubectl apply -f deploy_web.yaml 
  145  kubectl get pods
  146  kubectl get pods -o wide
  147  curl -L  192.168.242.74
  148  kubectl expose deploy web --port 80 --dry-run=client -o yaml
  149  kubectl expose deploy web --port 80 --dry-run=client -o yaml > svc_web.yaml
  150  vi svc_web.yaml 
  151  kubectl create -f svc_web.yaml 
  152  kubectl get svc
  153  curl -L 10.99.232.66
  154  curl -L 10.99.232.66/1
  155  curl -L 10.99.232.66/1
  156  curl -L 10.99.232.66/1
  157  curl -L 10.99.232.66/1
  158  curl -L 10.99.232.66/1
  159  while true; do curl -L 10.99.232.66/1: sleep 1; done
  160  while true; do curl -L 10.99.232.66/1; sleep 1; done
  161  ll /var/log/
  162  ll /var/log/syslog 
  163  grep -i join /var/log/syslog 
  164  sudo grep -i join /var/log/syslog 
  165  sudo tail -f /var/log/syslog 
  166  #kubectl -n kube-system get 
  167  ource <(kubectl completion bash)kk
  168  echo 'source <(kubectl completion bash)' >> .bashrc
  169  kubectl -n kube-system get pod kube-apiserver-cp 
  170  kubectl -n kube-system logs kube-apiserver-cp 
  171  kubectl -n kube-system logs kube-apiserver-cp  -w
  172  kubectl -n kube-system logs kube-apiserver-cp  -f
  173  ll
  174  sudo vi /etc/hosts
  175  more /etc/hosts
  176  kubectl get no
  177  #kubectl get no
  178  kubectl get no
  179  kubeadm token create --print-join-command
  180  kubectl get no
  181  ll /var/run/dockershim.sock
  182  ll /var/run/ | grep docker
  183  kubectl -n kube-system get cm kubeadm-config -o yaml
  184  ll /var/run/crio/
  185  ll /var/run/ | grep -i cri
  186  sudo crictl ps
  187  ll /var/run/crio/ | grep -i sock
  188  kubectl get no
  189  kubectl get no
  190  scp t-kube1-2:/usr/local/bin .
  191  scp -i ~/.ssh/key.pem t-kube1-2:/usr/local/bin .
  192  scp -i ~/.ssh/t-key.pem t-kube1-2:/usr/local/bin .
  193  scp -i ~/.ssh/t-key.pem t-kube1-2:/usr/local/bin/podman .
  194  ll podman 
  195  #sudo mv po
  196  sudo cp -a podman /usr/local/bin/
  197  which podman
  198  podman version
  199  podman image ls
  200  which podman
  201  for i in {1..12}; do scp podman kube${i}-1:podman; done
  202  for i in {1..12}; do ssh kube${i}-1 sudo mv podman /usr/local/bin/; done
  203  for i in {1..12}; do ssh kube${i}-1 podman version ; done
  204  vi deploy_web2.yaml
  205  kubectl create -f deploy_web2.yaml
  206  ubectl delete depl
  207  vi deploy_web2.yaml 
  208  kubectl create -f deploy_web2.yaml
  209  kubectl get deploy
  210  kubectl get deploy
  211  kubectl get deploy
  212  kubectl get deploy
  213  kubectl get deploy
  214  kubectl get pods
  215  kubectl describe pod web2-74667d6d57-2h57x 
  216  vi deploy_web2.yaml 
  217  podman image ls
  218  sudo podman image ls
  219  sudo podman image history docker.io/mjbright/k8s-demo:alpine1
  220  sudo podman image history docker.io/mjbright/k8s-demo:1
  221  sudo podman image inspect docker.io/mjbright/k8s-demo:1 
  222  sudo podman image inspect docker.io/mjbright/k8s-demo:1  | grep demo-binary
  223  vi deploy_web2.yaml 
  224  kubectl delete -f deploy_web2.yaml 
  225  kubectl get deploy
  226  kubectl create -f deploy_web2.yaml 
  227  kubectl get deploy
  228  #more deploy_web2.yaml 
  229  kubectl get pods
  230  more deploy_web2.yaml 
  231  kubectl expose deploy web2 
  232  kubectl describe service web2
  233  kubectl get svc
  234  vi deploy_web2.yaml 
  235  kubectl delete -f deploy_web2.yaml 
  236  kubectl create -f deploy_web2.yaml 
  237  kubectl describe service web2 | grep Endpoints
  238  kubectl get svc
  239  curl -L  10.96.25.43/1
  240  curl -L  10.96.25.43/1
  241  curl -L  10.96.25.43/1
  242  curl -L  10.96.25.43/1
  243  curl -L  10.96.25.43:81/1
  244  curl -L  10.96.25.43:81/1
  245  curl -L  10.96.25.43:81/1
  246  curl -L  10.96.25.43:81/1
  247  curl -L  10.96.25.43:81/1
  248  curl -L  10.96.25.43:81
  249  curl -L  10.96.25.43:80
  250  kubectl exec -it web2-dbf87865-2g2xs -- sh
  251  kubectl exec -it web2-dbf87865-2g2xs -- /app/demo-binary --version
  252  kubectl exec -it web2-dbf87865-2g2xs -- /app/demo-binary --listen :82
  253  kubectl exec -it web2-dbf87865-2g2xs -c k8s-demo-2 -- sh
  254  kubectl get pod
  255  kubectl get pod -o wide
  256  kubectl describe pod web-8c498f97d-4rpsg | grep Image
  257  kubectl exec -it web-8c498f97d-4rpsg -- sh
  258  find . -name Dockerfile
  259  more root  
  260  more LFD459/SOLUTIONS/s_03/Dockerfile 
  261  vi LFD459/SOLUTIONS/s_03/Dockerfile 
  262  kubectl get pods
  263  kubectl get pods -n kube-system 
  264  kubectl get pods -n kube-node-lease 
  265  kubectl describe namespaces kube-system 
  266  kubectl explain netpol.spec
  267  kubectl explain netpol.spec.ingress
  268  kubectl explain netpol.spec.ingress.from
  269  kubectl explain netpol.
  270  kubectl get no -o wide
  271  kubectl get svc
  272  kubectl get cm -A | grep adm
  273  kubectl get cm -n kube-system kubeadm-config 
  274  kubectl get cm -n kube-system kubeadm-config  -o yaml
  275  sudo -i
  276  kubectl get pods
  277  kubectl get pods -n kube-system --show-labels
  278  kubectl get deploy -n kube-system --show-labels
  279  kubectl -n kube-system rolling restart deploy coredns
  280  kubectl ro
  281  kubectl -n kube-system rollout restart deploy coredns
  282  cd ~/src/mjbright.k1spy/
  283  . ~/.venv/TRAINING/bin/activate
  284  ./k1s.py -n demo
  285  while true; do ./k1s.py -n demo; done
  286  while true; do ./k1s.py -n demo; read; done
  287  while true; do ./k1s.py -n demo; read; done
  288  while true; do ./k1s.py -n demo; read; done
  289  while true; do ./k1s.py -n demo; read; done
  290  cd ~/TAKE/HPA/
  291  vi README.md 
  292  kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"
  293  vi README.md 
  294  kubectl get hpa php-apache -o yaml > hpa-php-apache.yaml
  295  more hpa-php-apache.yaml 
  296  kubectl describe hpa php-apache 
  297  echo 'kubectl describe hpa php-apache ' >>  README.md 
  298  kubetl get hpa
  299  kubectl get hpa
  300  ll -tr
  301  more README.md 
  302  vi load-gen.sh
  303  cat load-gen.sh
  304  cat > load-gen.sh
  305  chmod +x load-gen.sh 
  306  cat load-gen.sh 
  307  #cat load-gen.sh 
  308  kubectl get svc 
  309  kubectl get svc php-apache -o json
  310  kubectl get svc php-apache -o json | jq '.spec.clusterIP'
  311  kubectl get svc php-apache -o json | jq -r '.spec.clusterIP'
  312  vi load-gen.sh 
  313  kubectl create ns frontend
  314  kubectl create ns backend
  315  kubetl -n backend create deploy backend --image mjbright/k8s-demo:alpine4 --replicas 5
  316  kubectl -n backend create deploy backend --image mjbright/k8s-demo:alpine4 --replicas 5
  317  kubectl -n backend get all
  318  kubectl example netpol
  319  #kubectl example netpol
  320  kubectl krew list
  321  ll ~/.krew/
  322  . ~/.bashrc 
  323  #kubectl example netpol
  324  kubectl example netpol
  325  ll -tr
  326  mkdir ../NetPol
  327  cd ../NetPol
  328  kubectl example netpol > default-deny.yaml
  329  kubectl example netpol > frontend-2-backend.yaml
  330  vi default-deny.yaml 
  331  kubectl -n backend create -f default-deny.yaml 
  332  vi default-deny.yaml 
  333  kubectl -n backend create -f default-deny.yaml 
  334  vi default-deny.yaml 
  335  kubectl -n backend create -f default-deny.yaml 
  336  kubectl -n backend expose deploy backend 
  337  kubectl -n backend expose deploy backend  --port 80
  338  kubectl get svc -n backend 
  339  curl -L 10.109.253.134
  340  kubectl get netpol
  341  kubectl get netpol -A
  342  vi default-deny.yaml 
  343  kubectl -n backend get all
  344  kubectl -n backend get all -o wide
  345  curl -L 192.168.171.97 
  346  ll
  347  vi frontend-2-backend.yaml 
  348  #kubectl create -f frontend-2-backend.yaml 
  349  vi frontend-2-backend.yaml 
  350  kubectl create -f frontend-2-backend.yaml 
  351  kubectl example netpol 
  352  kubectl explore netpol
  353  kubectl explore netpol.spec
  354  kubectl explain netpol.spec
  355  kubectl explain netpol.spec | less
  356  kubectl explain netpol.spec.ingress | less
  357  kubectl explain netpol.spec.ingress.fromt | less
  358  kubectl explain netpol.spec.ingress.from | less
  359  vi frontend-2-backend.yaml 
  360  kubectl create -f frontend-2-backend.yaml 
  361  curl -L 192.168.171.97 
  362  kubectl run testpod tester -n frontend --image alpine -- sh wget -qO - backend.backend.svc.cluster.local
  363  kubectl -n frontend get all
  364  kubectl -n frontend delete pod testpod 
  365  kubectl run testpod tester -n frontend --image alpine -- sh -c 'while true; do wget -qO - backend.backend.svc.cluster.local; sleep 1; done'
  366  kubectl -n frontend logs testpod 
  367  kubectl -n frontend logs testpod 
  368  kubectl -n frontend get po
  369  kubectl -n frontend describe po testpod 
  370  kubectl -n frontend delete po testpod 
  371  kubectl run testpod -n frontend --image alpine -- sh -c 'while true; do wget -qO - backend.backend.svc.cluster.local; sleep 1; done'
  372  kubectl -n frontend get po
  373  kubectl -n frontend logs testpod 
  374  kubectl -n frontend logs testpod  -f
  375  kubectl -n frontend exec -it testpod -- sh
  376  #kubectl label ns frontend 
  377  more frontend-2-backend.yaml 
  378  kubectl label ns frontend app=backend
  379  kubectl -n frontend logs testpod  -f
  380  kubectl -n frontend exec -it testpod -- sh
  381  kubectl label ns frontend app=frontend
  382  kubectl label ns frontend app=frontend --overwrite 
  383  kubectl -n frontend logs testpod  -f
  384  ll
  385  history > README.md
