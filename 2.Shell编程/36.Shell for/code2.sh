#!/bin/bash

sum=0
i=1
for ((; i <= 100; i++ )); do
    ((sum+=i))
done
echo "the sum is $sum"