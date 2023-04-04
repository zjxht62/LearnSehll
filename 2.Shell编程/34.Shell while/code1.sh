#!/bin/bash

i=1
sum=0

#while [[ i -le 100 ]]; do
while ((i<=100)); do
  ((sum += i))
  ((i++))
done
echo "The sum is: $sum"