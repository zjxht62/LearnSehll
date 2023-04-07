#!/bin/bash

sum=0
while read n; do
  if ((n<1 || n>100)); then
    continue
  fi
  ((sum+=n))
done

echo "sum=$sum"