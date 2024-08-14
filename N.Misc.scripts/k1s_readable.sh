#!/bin/bash

# Adapted from: https://itnext.io/the-worlds-simplest-kubernetes-dashboard-k1s-4246e03191df
#               https://github.com/weibeld/k1s

# Option handling:
case "$1" in
    -|-A|--all-namespaces) shift; set -- -A $*;;
    -v|--version)          echo "0.1.2_mjb"; exit;;
esac

ns=${1:-default}; res="${2:-pods}"

# Check dependencies present:
for d in jq watch curl kubectl; do which "$d" >/dev/null || { echo "Missing dependency: $d"; exit 1; }; done

# British ;-) Colour handling:
c() { echo -e "\033[$1m"; }
cc() { echo -e "\033[$1;1m"; }

# Get api URL: path for resource $res
printf Loading && while true; do printf . && sleep 0.1; done &

set -o pipefail
path=$(kubectl get "$res" "$([[ "$ns" = -A ]] && echo -A || echo -n=$ns)" -v 6 2>&1 >/dev/null | grep GET | tail -n 1 | sed -n 's#.*https://[^/]*\([a-z0-9/.-]*\).*#\1#p')
pid=$?
kill -9 "$!" && wait "$!" 2>/dev/null

[[ "$pid" -ne 0 ]] && echo -e "\nInvalid resource type: $res" && exit 1
[[ $(echo -n "${path//[^\/]}" | wc -c) -lt 5 ]] && ns=-
res=${path##*/}

exec 3< <(kubectl proxy -p 0)
#port=$(head -n 1 <&3 | sed 's/.*:\([0-9]\{4,5\}\)\b.*/\1/')
port=$(head -n 1 <&3 | sed 's/.*:\([0-9]\{4,5\}\).*/\1/')

file=$(mktemp)
cat <<EOF >"$file"
$(cc 36) ____ ____ ____
||$(cc 33)k$(cc 36) |||$(cc 33)1$(cc 36) |||$(cc 33)s$(cc 36) ||  $(cc 0)Kubernetes Dashboard$(cc 36)
||__|||__|||__||  $(cc 0)Namespace: $ns$(cc 36)
|/__\|/__\|/__\|  $(cc 0)Resources: $res$(c 0)

EOF

# Start background process looking out for events and writing them to $file:
curl -N -s "http://localhost:$port$path?watch=true" |
  while read -r event; do
    name=$(jq -r '.object.metadata.name' <<<"$event")

    case "$res" in

    pods)
      phase=$(jq -r '.object.status.phase' <<<"$event")
      is_ready=$(jq -r 'if .object.status | has("conditions") then .object.status.conditions[] | if select(.type=="Ready").status=="True" then "1" else "" end else "" end' <<<"$event")
      is_scheduled=$(jq -r 'if .object.status | has("conditions") then .object.status.conditions[] | if select(.type=="PodScheduled").status=="True" then "1" else "" end else "" end' <<<"$event")
      [[ "$is_scheduled" && ! "$is_ready" ]] && info=NonReady || info=$phase
      [[ "$info" = Running ]] && info=$(c 32)$info$(c 0) || info=$(c 33)$info$(c 0) ;;

    deployments|replicasets|statefulsets)
      spec=$(jq -r '.object.spec.replicas' <<<"$event")
      stat=$(jq -r '.object.status.readyReplicas // 0' <<<"$event")
      [[ "$stat" = "$spec" ]] && info="$(c 32)($stat/$spec)$(c 0)" || info="$(c 33)($stat/$spec)$(c 0)"
      [[ "$stat" = "0" ]] && info="$(c 31)($stat/$spec)$(c 0)" ;;

    esac

    case $(jq -r .type <<<"$event") in
      #ADDED)    echo "$name $info" >>"$file" ;;
      #MODIFIED) sed -i.bkp "s/^$name .*$/$name ${info//\//\\/}/" "$file" ;;
      #DELETED) sed -i.bkp "/^$name .*$/d" "$file";;
      ADDED)    echo "[$info] $name" >>"$file" ;;
      MODIFIED) sed -i.bkp "s/.*$name$/\[${info//\//\\/}\] $name/" "$file" ;;
      DELETED)  sed -i.bkp "/.*$name$/d" "$file";;
    esac
  done &

# Now just watch the fun as $file is updated:
watch -ctn 0.1 cat "$file"

