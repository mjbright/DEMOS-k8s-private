
# Region us-east:
  kubectl label node cp      region=us-east
  kubectl label node cp      zone="us-east-1"

  kubectl label node worker  region=us-east
  kubectl label node worker  zone="us-east-2"

# Region us-west:
  kubectl label node cp2 region=us-west
  kubectl label node cp2 zone="us-west-1"

  kubectl label node cp3 region=us-west
  kubectl label node cp3 zone="us-west-2"
