#!/bin/bash

sudo apt install jq

FILE=./hosts


if [ -f "$FILE" ]; then
  echo ${terraform output -json instance_ips} | jq -r '.[]' >> hosts
else
  echo "[servers]" > hosts
  echo ${terraform output -json instance_ips} | jq -r '.[]' >> hosts
fi


