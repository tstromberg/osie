#!/usr/bin/env bash

set -euxo nounset

MSTFLINT_RELEASE=4.15.0-1
MSTFLINT_SHA512=00a7302132ab6c4dd0d743dfa9a07c7468e8515f8f851a0a5f6ad2ae797e5a3a33142a8c8fb60a0286131054c14253baf92c96cbb051cf9231431062057249b2
MSTFLINT_BASEURL=https://github.com/Mellanox/mstflint/releases/download/

curl -L "${MSTFLINT_BASEURL}/v${MSTFLINT_RELEASE}/mstflint-${MSTFLINT_RELEASE}.tar.gz" >mstflint.tar.gz
apt install -y zlib1g-dev libibmad-dev libssl-dev g++
echo "${MSTFLINT_SHA512}  mstflint.tar.gz" | sha512sum -c
tar -zxvf mstflint.tar.gz
cd mstflint-$(echo $MSTFLINT_RELEASE | sed 's/v//' | sed 's/-1//')
./configure
make
make install
apt-get purge -y zlib1g-dev libibmad-dev libssl-dev g++
apt-get autoremove -y
