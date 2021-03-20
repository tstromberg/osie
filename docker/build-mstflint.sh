#!/usr/bin/env bash

set -euxo nounset

MSTFLINT_RELEASE=4.16.0-1
MSTFLINT_SHA512=cb04d3097ee8bd89756882999a5df26e067660fe2e3461611c1dd820db7bf8cfdabddb95df36d0cbdd1a469966cac22a64e1e86bdec72d915999d0a77f62f30f
MSTFLINT_BASEURL=https://github.com/Mellanox/mstflint/releases/download/

curl -L "${MSTFLINT_BASEURL}/v${MSTFLINT_RELEASE}/mstflint-${MSTFLINT_RELEASE}.tar.gz" >mstflint.tar.gz
apt install -y zlib1g-dev libibmad-dev libssl-dev g++
echo "${MSTFLINT_SHA512}  mstflint.tar.gz" | sha512sum -c
tar -zxvf mstflint.tar.gz
cd "mstflint-$(echo $MSTFLINT_RELEASE | sed 's/v//' | sed 's/-1//')"
./configure
make -j"$(nproc)"
make install
apt-get purge -y zlib1g-dev libibmad-dev libssl-dev g++
apt-get autoremove -y
