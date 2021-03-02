#!/bin/bash -xe
sudo rm -rf /var/run/dbus
sudo mkdir /var/run/dbus
sudo dbus-daemon --system

rm -rf /home/vscode/tpmstate
mkdir /home/vscode/tpmstate
sudo swtpm_setup --tpm2 \
    --tpmstate /home/vscode/tpmstate \
    --createek --decryption --create-ek-cert \
    --create-platform-cert \
    --display
sudo chown -R vscode:vscode /home/vscode/tpmstate

swtpm socket --tpm2 \
    --tpmstate dir=/home/vscode/tpmstate \
    --flags startup-clear \
    --ctrl type=tcp,port=2322 \
    --server type=tcp,port=2321 \
    --daemon
nohup tpm2-abrmd \
    --logger=stdout \
    --tcti=swtpm: \
    --flush-all >/home/vscode/abrmd.log &

sudo python3 setup.py develop
