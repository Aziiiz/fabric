#!/bin/bash
source base_parameters.sh

export FABRIC_LOGGING_SPEC=INFO
export CORE_PEER_MSPCONFIGPATH=${FABRIC_CFG_PATH}/crypto-config/peerOrganizations/${PEER_DOMAIN}/peers/${FAST_PEER_ADDRESS}.${PEER_DOMAIN}/msp

p_addr="$(get_correct_peer_address "${FAST_PEER_ADDRESS}")"
export CORE_PEER_ID=${p_addr}
export CORE_PEER_ADDRESS=${p_addr}:7051
export CORE_PEER_GOSSIP_EXTERNALENDPOINT=${p_addr}:7051
export CORE_PEER_LISTENADDRESS=0.0.0.0:7051
export CORE_PEER_CHAINCODEADDRESS=${p_addr}:7052
export CORE_PEER_CHAINCODELISTENADDRESS=0.0.0.0:7052
export CORE_PEER_GOSSIP_USELEADERELECTION=false
export CORE_PEER_GOSSIP_ORGLEADER=true

export CORE_PEER_LOCALMSPID=Org1MSP

rm /var/hyperledger/production/* -r # clean up data from previous runs
(cd "${FABRIC_ROOT}" && make peer)

# peer node start can be run without the storageAddr. In that case those modules will not be decoupled to different nodes
s=""
if [[ -n ${STORAGE_ADDRESS} ]]; then
  echo "Starting with decoupled storage server ${STORAGE_ADDRESS}"
  s="--storageAddr $(get_correct_peer_address "${STORAGE_ADDRESS}"):10000"
fi

v=""
if [[ -n ${VALIDATION_ADDRESS} ]]; then
  echo "Starting with decoupled validation server ${VALIDATION_ADDRESS}"
  v="--validatorAddr $(get_correct_peer_address "${VALIDATION_ADDRESS}"):11000"
fi

# shellcheck disable=SC2086
peer node start ${s} ${v}
