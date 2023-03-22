#!/bin/bash

begin_time=`date +%s` # 开始时间，用反引号替换
sleep 20s
finish_time=$(date +%s) #结束时间，用$()替换
run_time=$((finish_time-begin_time))
echo "Begin time ${begin_time}"
echo "Finish time ${finish_time}"
echo "run time:${run_time}s"

