#!/bin/bash
version=$(curl --silent "https://api.steamcmd.net/v1/info/1362640 " | jq '.data."1362640".depots.branches.public.buildid' -r)
currentversion=$(cat currentversion)
echo "currentversion:$currentversion version:$version"
if [[ -z "${version}" ]]; then
    exit
fi
if ! [[ $version =~ ^[0-9]+$ ]]; then
    exit
fi
echo "$version" >currentversion
if [[ "$currentversion" == "$version" ]]; then
    exit
fi
