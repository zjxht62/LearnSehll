#!/bin/bash

function getsum() {
    local sum=0

    for n in $@
    do
      ((sum+=n))
    done

    return $sum
}

getsum 10 20 55 15
echo $?