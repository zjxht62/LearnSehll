#!/bin/bash

sum=0
while read n; do
  if ((n>0)); then
    ((sum+=n))
  else
    break
  fi
done

echo "sum=$sum"