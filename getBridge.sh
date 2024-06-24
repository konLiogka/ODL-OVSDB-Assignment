#!/bin/bash

username="admin"
password="admin"
controller="localhost"

if [ $# -ne 2 ]; then
	echo "Input: $0 <host-name> <bridge-name>"
	exit 1
fi

curl_cmd="curl -u $username:$password http://$controller:8181/restconf/config/network-topology:network-topology/topology/ovsdb:1/node/ovsdb:%2F$1%2Fbridge%2F$2/ | jq"

echo "$curl_cmd"
eval "$curl_cmd"
 
