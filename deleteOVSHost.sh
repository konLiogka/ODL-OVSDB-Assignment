#!/bin/bash

username="admin"
password="admin"
controller="localhost"

if [ $# -ne 1 ]; then
    echo "Input: $0 <host-name>"
    exit 1
fi

 
curl_cmd="curl -u $username:$password -X DELETE http://$controller:8181/restconf/config/network-topology:network-topology/topology/ovsdb:1/node/ovsdb:%2F%2F$1 | jq"
echo "$curl_cmd"
eval "$curl_cmd"
 
bridges_cmd="curl -u $username:$password http://$controller:8181/restconf/config/network-topology:network-topology/topology/ovsdb:1/node/ovsdb:%2F%2F$1/bridge | jq -r '.nodes[].node-id'"

 
while IFS= read -r bridge_id; do
    if [ -n "$bridge_id" ]; then
        bridge_name=$(basename "$bridge_id")
        echo "Deleting bridge: $bridge_name"
        
 
        curl_cmd="curl -u $username:$password -X DELETE http://$controller:8181/restconf/config/network-topology:network-topology/topology/ovsdb:1/node/ovsdb:%2F%2F$1%2Fbridge%2F$bridge_name | jq"
        echo "$curl_cmd"
        eval "$curl_cmd"
 
        curl_cmd="curl -u $username:$password -X DELETE http://$controller:8181/restconf/config/network-topology:network-topology/topology/ovsdb:1/node/ovsdb:%2F%2F$1%2Fbridge%2F$bridge_name/termination-point | jq"
        echo "$curl_cmd"
        eval "$curl_cmd"
    fi
done < <(echo "$bridges_cmd")