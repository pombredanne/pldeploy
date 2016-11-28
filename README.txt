Create ssh config:
==================
echo $'StrictHostKeyChecking no \nBatchMode yes' > ~/.ssh/config
chmod 600 ~/.ssh/config

./whoisalive.sh all-nodes.txt
./push.sh PACKAGE_NAME
./launch.sh PACKAGE_NAME

