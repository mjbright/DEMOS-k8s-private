
Re-think pod Affinity/anti-affinity use case
- is it really a good use case (doesn't work well if number of Pods/Nodes doesn't match)

# Taints & Tolerations

Another use case
- Taint nodes which have a GPU to avoid non-GPU workloads
- Tolerate GPU workload Pods to be schedulable on GPU Nodes
- Also use nodeSelector for GPU Nodes/Pods

