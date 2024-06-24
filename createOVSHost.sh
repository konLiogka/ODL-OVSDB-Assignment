#!/bin/bash

username="admin"
password="admin"
controller="localhost"
port="6640"
if [ $# -ne 2 ]; then
	echo "Input: $0 <ovs-ip> <host-name>"
	exit 1
fi


curl_cmd="curl -u $username:$password -X PUT -H \"Content-Type: application/json\" -d '{
	\"network-topology:node\": [
	{
		\"node-id\": \"ovsdb://$2\",
		\"ovsdb:connection-info\": {
			\"ovsdb:remote-port\": \"$port\",
			\"ovsdb:remote-ip\": \"$1\"
		}
	}
	]
}' http://$controller:8181/restconf/config/network-topology:network-topology/topology/ovsdb:1/node/ovsdb:%2F%2F$2 | jq"

echo "$curl_cmd"
eval "$curl_cmd"
 
		
