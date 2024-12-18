  955  2024-12-18 18:18:54 kubectl apply -f web-config-blue.yaml 
  956  2024-12-18 18:19:09 kubectl apply -f deploy-web-envfrom-cm.yaml 
  957  2024-12-18 18:21:10 vi deploy-web-envfrom-cm.yaml 
  958  2024-12-18 18:21:46 kubectl apply -f deploy-web-envfrom-cm.yaml 
  959  2024-12-18 18:21:53 kubectl get deploy
  960  2024-12-18 18:21:58 kubectl get pods -o wide
  961  2024-12-18 18:22:04 curl  10.0.1.151 
  962  2024-12-18 18:22:20 kubectl exec -it web-envfrom-cm-7d8587cd5c-rmpvn -- env
  963  2024-12-18 18:22:34 more web-config-blue.yaml 
  964  2024-12-18 18:23:02 kubectl apply -f web-config-red.yaml 
  965  2024-12-18 18:23:16 #kubectl rollout restart deploy web-envfrom-cm 
  966  2024-12-18 18:23:18 curl  10.0.1.151 
  967  2024-12-18 18:23:20 kubectl rollout restart deploy web-envfrom-cm 
  968  2024-12-18 18:23:26 kubectl get pod -o wide
  969  2024-12-18 18:23:35 curl  10.0.0.158 
  970  2024-12-18 18:23:43 #kubectl apply -f deploy-web-envfrom-cm.yaml 
  971  2024-12-18 18:23:54 kubectl apply -f deploy-web-env-cm.yaml 
  972  2024-12-18 18:26:36 vi deploy-web-env-cm.yaml 
  973  2024-12-18 18:29:54 kubectl apply -f deploy-web-env-cm.yaml 
  974  2024-12-18 18:29:57 vi deploy-web-env-cm.yaml 
  975  2024-12-18 18:31:26 kubectl apply -f deploy-web-env-cm.yaml 
  976  2024-12-18 18:31:31 kubectl get pods
  977  2024-12-18 18:31:37 kubectl get pods -o wide
  978  2024-12-18 18:31:44 curl  10.0.1.102 
  979  2024-12-18 18:31:53 kubectl apply -f web-config-blue.yaml 
  980  2024-12-18 18:32:02 kubectl rollout restart deploy web-env-cm 
  981  2024-12-18 18:32:05 curl  10.0.1.102 
  982  2024-12-18 18:32:14 kubectl get pods -o wide
  983  2024-12-18 18:32:35 curl 10.0.1.76
  984  2024-12-18 18:32:37 ll
  985  2024-12-18 18:32:53 kubectl apply -f deploy-web-volume-cm.yaml 
  986  2024-12-18 18:32:59 kubectl get pods -o wide
  987  2024-12-18 18:33:07 curl  10.0.1.82 
  988  2024-12-18 18:33:15 kubectl apply -f web-config-red.yaml 
  989  2024-12-18 18:33:22 curl  10.0.1.82 
  990  2024-12-18 18:33:29 kubectl rollout restart deploy web-volume-cm 
  991  2024-12-18 18:33:35 kubectl get pods -o wide
  992  2024-12-18 18:33:41 curl 10.0.0.35 
