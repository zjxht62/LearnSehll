#!/bin/bash

sum=0
for n in 1 2 3 4 5 6
do
  echo $n
  ((sum+=n))
done
echo "The sum is $sum"