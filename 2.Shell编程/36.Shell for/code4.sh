#!/bin/bash

sum=0
for (( i = 1; i <= 100;)); do
    ((sum+=i))
    ((i++))
done
echo "the sum is $sum"