#!/bin/bash

alias timestamp='date +%s'

begin=`timestamp`
sleep 10s
finish=$(timestamp)
difference=$((finish - begin))

echo "run time is : ${difference}s"