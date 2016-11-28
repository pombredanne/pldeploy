#!/bin/bash
PACKAGE=$1
OUTDIR=results/$PACKAGE
PACKAGE_TAR=$PACKAGE.tar.gz
SLICENAME="darmstadtple_ids"
NODELIST="nodes.txt"

eval `ssh-agent`
ssh-add planetlab-key

rm $PACKAGE/*.*~
echo "creating tar.gz for $PACKAGE"
tar -zcvf $PACKAGE_TAR $PACKAGE >/dev/null

echo "Pushing tar to nodes"
./vxargs.py -t 90 -p -P 15 -y -o $OUTDIR/deploy -a $NODELIST scp $PACKAGE_TAR $SLICENAME@{}:~
python build-successlists.py $OUTDIR/deploy

echo "Extracting tar in nodes"
./vxargs.py -t 90 -p -P 15 -y -o $OUTDIR/extract -a $OUTDIR/deploy/goodlist.txt ssh $SLICENAME@{} "tar -zxvf $PACKAGE_TAR; rm $PACKAGE_TAR; exit"
python build-successlists.py $OUTDIR/extract

rm $PACKAGE_TAR

echo "done"
