#! /bin/bash

sudo apt-get update
sudo apt install nodejs
sudo apt-get install build-essential
sudo apt install npm
git clone https://github.com/hyperledger/caliper-benchmarks.git
cd caliper-benchmarks/
git checkout d02cc8bbc17afda13a0d3af1122d43bfbfc45b0a
npm init -y
npm install --only=prod @hyperledger/caliper-cli@0.4
cd networks/fabric/config_solo_raft/
./generate.sh
cd ~
cd caliper-benchmarks/
sudo snap install docker
sudo docker pull hyperledger/fabric-ccenv:1.4.4
sudo docker tag hyperledger/fabric-ccenv:1.4.4 hyperledger/fabric-ccenv:latest
npm install --save fabric-client fabric-ca-client
curl https://raw.githubusercontent.com/creationix/nvm/v0.25.0/install.sh | bash
source ~/.profile
nvm install 12
wget https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz
tar -xvf Python-2.7.18.tgz
cd Python-2.7.18/
./configure
make
sudo make install
sudo ln -sf /usr/local/bin/python2.7 /usr/bin/python
python --version
npm rebuild grpc --force
sudo npx caliper launch manager --caliper-workspace . --caliper-benchconfig benchmarks/samples/fabric/marbles/config.yaml --caliper-networkconfig networks/fabric/v1/v1.4.4/2org1peercouchdb_raft/fabric-go-tls-solo.yaml