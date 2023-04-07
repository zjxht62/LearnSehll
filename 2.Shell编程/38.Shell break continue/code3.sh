#!/bin/bash

i=0
while ((++i)); do  #外层循环
    j=0;
    while ((++j)); do  #内层循环
        if((i>4)); then
            break 2  #跳出内外两层循环
        fi
        if((j>4)); then
            break  #跳出内层循环
        fi
        printf "%-4d" $((i*j))
    done

    printf "\n"
done