#!/usr/bin/env bash

# ==========================================================
# Author: https://github.com/sevaho
# Repo: https://github.com/sevaho/scripts
#
# ==========================================================

CMD=$(nk --gen user --pubout)
PRIVKEY=`echo -n $CMD | cut -d " " -f 1`
echo -e "private key: \t\t $PRIVKEY"

PRIVKEY_B64=`echo -n $PRIVKEY | base64 -w0`
echo -e "private key base64: \t $PRIVKEY_B64"

PUBKEY=`echo -n $CMD | cut -d " " -f 2`
echo "----------------------------------"
echo -e "public key: \t\t $PUBKEY"
