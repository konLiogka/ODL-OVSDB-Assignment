#!/bin/bash

username="admin"
password="admin"
controller="localhost"


if [ $# -ne 3 ]; then
	echo "Input: $0 <host-name> <bridge-name> <port-name>>"
	exit 1
fi


curl_cmd="curl -u $username:$password http://$controller:8181/restconf/operational/network-topology:network-topology/topology/ovsdb:1/node/ovsdb:%2F%2F$1%2Fbridge%2F$2/termination-point/$3 | jq"

echo "$curl_cmd"
eval "$curl_cmd"
 
















