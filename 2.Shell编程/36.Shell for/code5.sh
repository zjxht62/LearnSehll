#!/bin/bash

sum=0
i=1
for ((;;)); do
  if ((i>100)); then
      break
  fi
    ((sum+=i))
    ((i++))
done
echo "the sum is $sum"