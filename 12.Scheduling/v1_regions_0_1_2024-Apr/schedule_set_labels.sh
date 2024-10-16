
# Region 0:
  kubectl label node cp      region=0
  kubectl label node cp      zone="r0-0"

  kubectl label node worker  region=0
  kubectl label node worker  zone="r0-1"

# Region 1:
  kubectl label node worker2 region=1
  kubectl label node worker2 zone="r1-0"

  kubectl label node worker3 region=1
  kubectl label node worker3 zone="r1-1"
