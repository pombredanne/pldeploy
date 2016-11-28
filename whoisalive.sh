#!/bin/bash
SLICENAME="darmstadtple_ids"
NODELIST=$1
OUTDIR=results/whoisalive

eval `ssh-agent`
ssh-add planetlab-key

echo "Checking who is alive using ping"
./vxargs.py -t 90 -p -P 15 -y -o $OUTDIR/pingtest -a $NODELIST ping -q -c5 {}
python build-successlists.py $OUTDIR/pingtest
NODELIST=$OUTDIR/pingtest/goodlist.txt

echo "Checking who is alive using ssh"
./vxargs.py -t 90 -p -P 15 -y -o $OUTDIR/sshtest -a $NODELIST ssh $SLICENAME@{} "exit"
python build-successlists.py $OUTDIR/sshtest

cp $OUTDIR/sshtest/goodlist.txt $OUTDIR/goodlist.txt
