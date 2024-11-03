
# ConfigMap mounted as a volume

1. Create Pod using pod_cm_volume.yaml

2. Create ConfigMap using configmap_v1.yaml

3. kubectl logs -f testpod

   Observe key/value pairs 

4. Update ConfigMap using configmap_v2.yaml

5. kubectl logs -f testpod

   Observe key/value pairs updated after ~ 1 minute

CONCLUSION: but application might not poll filesystem,
            SO general way is to trigger a "kubectl rollout restart deploy xxx" to force re-read of updated file

# ConfigMap used for env Vars

1. Delete ConfigMap cm1

2. Create Pod using pod_cm_env.yaml
   MENTION that version with while loop would not show any changes ...
   DEMONSTRATE version with simple sleep

3. Create ConfigMap using configmap_v1.yaml

4. kubectl logs -f testpod

   Observe key/value pairs 

5. Update ConfigMap using configmap_v2.yaml

6. kubectl logs -f testpod

   Observe key/value pairs updated after CONTAINER RESTART

CONCLUSION: but application might not exit so easily !!
            SO general way is to trigger a "kubectl rollout restart deploy xxx" to force re-creation of containers/env vars


