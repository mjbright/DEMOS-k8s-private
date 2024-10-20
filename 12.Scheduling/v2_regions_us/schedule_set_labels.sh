
# Region us-east:
  kubectl label node cp      region=us-east --overwrite
  kubectl label node cp      zone="us-east-1" --overwrite

  kubectl label node worker  region=us-east --overwrite
  kubectl label node worker  zone="us-east-2" --overwrite

# Region us-west:
  kubectl label node secondcp region=us-west --overwrite
  kubectl label node secondcp zone="us-west-1" --overwrite

  kubectl label node thirdcp region=us-west --overwrite
  kubectl label node thirdcp zone="us-west-2" --overwrite
