#!/bin/bash

sudo apt install jq

FILE=./hosts


if [ -f "$FILE" ]; then
  echo ${terraform output -json dev_env_ip} | jq -r '.[]' >> hosts
else
  echo "[servers]" > hosts
  echo ${terraform output -json dev_env_ip} | jq -r '.[]' >> hosts
fi


