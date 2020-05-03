#!/bin/bash

set -euo pipefail

BITCOIN_DIR=/root/.bitcoin
BITCOIN_CONF=${BITCOIN_DIR}/bitcoin.conf

# If config doesn't exist, initialize with sane defaults for running a
# non-mining node.

if [ ! -e "${BITCOIN_CONF}" ]; then
  tee -a >${BITCOIN_CONF} <<EOF

# For documentation on the config file, see
#
# the bitcoin source:
#   https://github.com/bitcoin/bitcoin/blob/master/share/examples/bitcoin.conf
# the wiki:
#   https://en.bitcoin.it/wiki/Running_Bitcoin

# server=1 tells Bitcoin-Qt and bitcoind to accept JSON-RPC commands
server=1

# You must set rpcuser and rpcpassword to secure the JSON-RPC api
rpcuser=${BITCOIN_API_USERNAME}
rpcpassword=${BITCOIN_API_PASSWORD}

# How many seconds bitcoin will wait for a complete RPC HTTP request.
# after the HTTP connection is established.
rpcclienttimeout=${BITCOIN_API_CLIENTTIMEOUT:-300}

rpcallowip=${BITCOIN_API_ALLOWIP:-0.0.0.0/0}

rpcbind=${BITCOIN_API_IP:-0.0.0.0}

# Listen for RPC connections on this TCP port:
rpcport=${BITCOIN_API_PORT:-8332}

# Print to console (stdout) so that "docker logs bitcoind" prints useful
# information.
printtoconsole=${BITCOIN_PRINTTOCONSOLE:-1}

# We probably don't want a wallet.
disablewallet=0

# Enable an on-disk txn index. Allows use of getrawtransaction for txns not in
# mempool.
txindex=${BITCOIN_TXINDEX:-0}

# Run on the test network instead of the real bitcoin network.
testnet=0

# Set database cache size in MiB
# dbcache=${BITCOIN_DBCACHE:-512}

EOF
fi

if [ $# -eq 0 ]; then
  exec bitcoind -datadir=${BITCOIN_DIR} -conf=${BITCOIN_CONF}
else
  exec "$@"
fi
