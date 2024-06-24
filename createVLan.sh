#!/bin/bash

username="admin"
password="admin"
controller="localhost"
port="6640"

if [ $# -ne 6 ]; then
	echo "Input: $0 <host-name> <bridge-name> <port-name> <vlan-ip> <vlan-tag> <trunk>"
	exit 1
fi




curl_cmd="curl -u $username:$password  -X PUT -H \"Content-Type: application/json\" -d '{
		  \"network-topology:termination-point\": [
		    {
		      \"ovsdb:options\": [
			{
			  \"ovsdb:option\": \"remote_ip\",
			  \"ovsdb:value\" : \"$4\"
			}
		      ],
		      \"ovsdb:name\": \"$3\",
		      \"ovsdb:interface-type\": \"ovsdb:interface-type-vxlan\",
		      \"tp-id\": \"$3\",
		      \"vlan-tag\": \"$5\",
		      \"trunks\": [
			{
			  \"trunk\": \"$6\"
			}
		      ],
		      \"vlan-mode\":\"access\"
		    }
		  ]
		}' http://$controller:8181/restconf/config/network-topology:network-topology/topology/ovsdb:1/node/ovsdb:%2F%2F$1%2Fbridge%2F$2/termination-point/$3/  | jq"

echo "$curl_cmd"
eval "$curl_cmd"
