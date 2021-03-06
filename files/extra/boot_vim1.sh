#!/bin/sh

## hyphop ##

# change bootable to VIM?

D=$(dirname $0)
N=$(basename $0)

BOARD=${N#*_}
BOARD=${BOARD%.sh}

D=$(dirname $0)
R=$(realpath $D)
M="$(realpath $D/../../)"
MNT=$(grep $M /proc/mounts)
[ "$MNT" ] && {
MN2=${MNT%% *}
MN3=
case $MN2 in
    /dev/sd*)
    MN3=${MN2%?}
    ;;
    /dev/mmc*)
    MN3=${MN2%??}
    ;;
    
esac
echo "[i] auto detect mounted to >> $MN3 <<">&2
}

echo "[i] krescue change sd boot to $BOARD">&2

sh $D/uboot_write.sh $D/../u-boot.$BOARD.sd.bin $MN3 || exit 1

echo "[i] OK bootable changed to $BOARD"