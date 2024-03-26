#!/usr/bin/env bash

FILE=./hosts


if [ -f "$FILE" ]; then
  terraform_output=$(terraform output -json instance_ips)
  echo "$terraform_output" | sed 's/\[//; s/\]//; s/,/\n/g; s/"//g' >> hosts
else
  echo "[servers]" > hosts
  terraform_output=$(terraform output -json instance_ips)
  echo "$terraform_output" | sed 's/\[//; s/\]//; s/,/\n/g; s/"//g' >> hosts
fi


