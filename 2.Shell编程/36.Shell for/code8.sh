#!/bin/bash

sum=0
for i in {1..100}
do
  ((sum+=i))
done
echo "The sum is $sum"