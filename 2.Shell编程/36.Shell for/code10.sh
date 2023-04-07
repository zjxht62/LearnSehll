#!/bin/bash

sum=0

for n in $(seq 2 2 100)
do
  ((sum+=n))
done

echo "$sum"
