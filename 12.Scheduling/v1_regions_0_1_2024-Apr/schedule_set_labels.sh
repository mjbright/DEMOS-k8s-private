
#NODE3=worker2
#NODE3=cp2
NODE3=secondcp

#NODE4=worker3
#NODE4=cp3
NODE4=thirdcp

# Region 0:
  kubectl label node cp      region=0
  kubectl label node cp      zone="r0-0"

  kubectl label node worker  region=0
  kubectl label node worker  zone="r0-1"

# Region 1:
  kubectl label node $NODE3 region=1
  kubectl label node $NODE3 zone="r1-0"

  kubectl label node $NODE4 region=1
  kubectl label node $NODE4 zone="r1-1"

