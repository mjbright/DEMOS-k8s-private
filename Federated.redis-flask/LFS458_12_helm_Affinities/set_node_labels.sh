
#NODE3=worker2
#NODE3=cp2
NODE3=secondcp

#NODE4=worker3
#NODE4=cp3
NODE4=thirdcp

# Region 0:
  kubectl label node cp      region=us-east
  kubectl label node cp      zone="us-east-1"

  kubectl label node worker  region=us-east
  kubectl label node worker  zone="us-east-2"

# Region 1:
  kubectl label node $NODE3 region=us-west
  kubectl label node $NODE3 zone="us-west-1"

  kubectl label node $NODE4 region=us-west
  kubectl label node $NODE4 zone="us-west-2"

