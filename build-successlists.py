import os
import sys

if len(sys.argv) == 2:
    resultdir = sys.argv[1]
    if resultdir[len(resultdir) - 1] != '/':
        resultdir += '/'

    goodfp = open(resultdir + "goodlist.txt", "w")
    badfp = open(resultdir + "badlist.txt", "w")

    for f in os.listdir(resultdir):
        bn = os.path.basename(f)
        idx = bn.find('.status')
        if idx > -1:
            fp = open(resultdir + f, 'r')
            value = fp.readline().strip()
            fp.close()
            if len(value) == 1 and value == '0':
                goodfp.write(bn[0:idx] + '\n')
            else:
                badfp.write(bn[0:idx] + '\n')
    goodfp.close()
    badfp.close()
else:
    print "Required parameters: vxargs-result-dir"