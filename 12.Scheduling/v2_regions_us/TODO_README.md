
Study this at:
- https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/
- https://stackoverflow.com/questions/72240224/what-is-topologykey-in-pod-affinity
- https://kodekloud.com/community/t/hi-there-i-have-questions-related-to-topologykey-1-is-that-required-for-po/390035

UPDATE nodeAffinitySlide
=> split slide, add notes about
   - nodeSelectorTerms are ORed
   - matchExpressions  are ANDed


UPDATE podAffinity/podAntiAffinity demo
   - Problems seen if create redis & webserver at same time because of async nature.
     e.g. if 3 out of 4 redis Pods are scheduled across (3 of) the nodes
          if a 4th webserver pod is scheduled before ther 4th redis Pod, it has to be scheduled on one of the 3 Nodes
          (so we get a duplicate)
     - topology is taken as preferred (even in a required pAA rule)

OTHER:
   - look at pod.spec.topologySpreadConstraints


