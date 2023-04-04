#!/bin/bash
read m
read n
sum=0
while ((m <= n))
do
    ((sum += m))
    ((m++))
done
echo "The sum is: $sum"