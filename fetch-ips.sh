#!/usr/bin/env bash

#install jq if needed
sudo apt install jq -y

FILE=./hosts


if [ -f "$FILE" ]; then
  terraform_output=$(terraform output -json instance_ips)
  echo "$terraform_output" | jq -r '.[]' >> hosts
else
  echo "[servers]" > hosts
  terraform_output=$(terraform output -json instance_ips)
  echo "$terraform_output" | jq -r '.[]' >> hosts
fi


