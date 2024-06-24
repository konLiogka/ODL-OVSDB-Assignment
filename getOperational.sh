#!/bin/bash

username="admin"
password="admin"
controller="localhost"

curl_cmd="curl -u $username:$password http://$controller:8181/restconf/operational/network-topology:network-topology/topology/ovsdb:1 | jq"

echo "$curl_cmd"
eval "$curl_cmd"
 
