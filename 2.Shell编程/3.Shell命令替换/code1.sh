#!/bin/bash

begin_time=`date` # 开始时间，用反引号替换
sleep 20s
finish_time=$(date) #结束时间，用$()替换

echo "Begin time ${begin_time}"
echo "Finish time ${finish_time}"

