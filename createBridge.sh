#!/bin/bash

username="admin"
password="admin"
controller="localhost"
port="6640"

if [ $# -ne 2 ]; then
	echo "Input: $0 <host-name> <bridge-name>"
	exit 1
fi

read -r -d '' json_data <<EOF
{
  "network-topology:node": [
    {
      "node-id": "ovsdb://$1/bridge/$2",
      "ovsdb:bridge-name": "$2",
      "ovsdb:protocol-entry": [
        {
          "protocol": "ovsdb:ovsdb-bridge-protocol-openflow-10"
        }
      ],
      "ovsdb:managed-by": "/network-topology:network-topology/network-topology:topology[network-topology:topology-id='ovsdb:1']/network-topology:node[network-topology:node-id='ovsdb://$1']"
    }
  ]
}
EOF


 curl -u $username:$password -X PUT -H "Content-Type: application/json" -d "$json_data" "http://$controller:8181/restconf/config/network-topology:network-topology/topology/ovsdb:1/node/ovsdb:%2F%2F$1%2Fbridge%2F$2" | jq

 
