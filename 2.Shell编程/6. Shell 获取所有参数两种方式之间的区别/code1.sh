#!/bin/bash

echo "print each param form \"\$*\""
for var in "$*"
do
  echo "$var"
done

echo "print each param form \"\$@\""
for var in "$@"
do
  echo "$var"
done