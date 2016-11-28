#!/bin/bash
PACKAGE=$1
OUTDIR=results/$PACKAGE
SLICENAME="darmstadtple_ids"
NODELIST="nodes.txt"

eval `ssh-agent`
ssh-add planetlab-key

echo "Running $PACKAGE server on nodes"
./vxargs.py -t 90 -p -P 15 -y -o $OUTDIR/run -a $NODELIST ssh $SLICENAME@{} "cd $PACKAGE; script -c 'sudo python plds.py'; exit"
python build-successlists.py $OUTDIR/run

echo "done"
