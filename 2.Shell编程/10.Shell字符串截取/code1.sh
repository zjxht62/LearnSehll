#!/bin/bash

url="http://c.biancheng.net/index.html"
echo ${url#*/}
echo ${url##*/}

str="---aa+++aa@@@"
echo ${str#*aa}   #结果为 +++aa@@@
echo ${str##*aa}  #结果为 @@@