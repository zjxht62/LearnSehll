#!/bin/bash

sum=0
i=1
until (( i>100 )); do
  ((sum+=i))
  ((i++))
done
echo "The sum is: $sum"
