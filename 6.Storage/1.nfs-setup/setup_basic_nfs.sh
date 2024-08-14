#!/bin/bash

MNT=/mnt/nfs-vol

CP=k8scp
CP=$( hostname )
CP_IP=$( hostname -i  | awk '{ print $1; }' )

WO=worker
KEY=~/.ssh/t-key.pem
KEY=~/.ssh/student2022_rsa
ssh="ssh -i $KEY $WO"

die() { echo "$0: die - $*" >&2; exit 1; }

grep -q " $WO" /etc/hosts || die "No $WO entry found in /etc/hosts"

sudo mkdir -p $MNT
sudo chmod 1777 $MNT

$ssh uptime || die "Failed to ssh to $WO"

## -- Funcs: ----------------------------------------------------

PRESS() {
    echo; echo $*
    echo "Press return>"
    read DUMMY
    [ "$DUMMY" = "q" ] && exit 0
    [ "$DUMMY" = "Q" ] && exit 0
}

CONFIGURE_NFS_CP() {
    PRESS "---- Configuring NFS on $CP node:"
    dpkg -l | grep nfs-kernel-server || {
        echo; echo 'sudo apt-get update && sudo apt-get install -y nfs-kernel-server'
        sudo apt-get update && sudo apt-get install -y nfs-kernel-server
    }

    [ ! -f $MNT/NFScreation.log ] && {
        echo; echo sudo tee $MNT/NFScreation.log
        #sudo bash -c 'echo $(date): NFS volume created from host $(hostname) > $MNT/NFScreation.log'
        bash -c "echo $(date): NFS volume created from host $(hostname)" | sudo tee $MNT/NFScreation.log
    }
    echo; ls -al $MNT/NFScreation.log

    grep $MNT /etc/exports || {
        echo $MNT/ '*(rw,sync,no_root_squash,subtree_check)' | sudo tee -a /etc/exports 
        #cat /etc/exports 
        # Reload exports:
        sudo exportfs -ra
    }
}

CONFIGURE_NFS_WO() {
    PRESS "---- Configuring NFS on $WO node:"
    $ssh sudo dpkg -l | grep nfs-common || $ssh sudo apt-get -y install nfs-common
    $ssh showmount -e $CP_IP
    $ssh sudo mkdir /mnt/nfs-vol
    $ssh sudo mount $CP_IP:$MNT /mnt/nfs-vol
    echo; $ssh ls -l /mnt/nfs-vol
}

## -- Main: -----------------------------------------------------

#case $(hostname) in
    #k8scp) CP=k8scp;;
    #cp) CP=cp;;

    #*)     die "Unexpected node name $(hostname)"
#esac

CONFIGURE_NFS_CP
CONFIGURE_NFS_WO


