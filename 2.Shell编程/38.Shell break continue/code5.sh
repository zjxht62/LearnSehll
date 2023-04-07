#!/bin/bash

for (( i = 1; i <= 5; i++ )); do
    for (( j = 1; j <= 5; j++ )); do
        if ((i*j==12)); then
          continue 2
        fi
        printf "%d*%d=%-4d" $i $j $((i*j))
    done
    printf "\n"
done