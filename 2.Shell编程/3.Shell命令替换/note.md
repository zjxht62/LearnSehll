# Shell命令替换：将命令的输出结果赋值给变量
Shell中有两种方式可以完成命令替换，一种是反引号&#96;,一种是`$()`
```shell
variable=`commands`
variable=$(commands)
```
其中，variable 是变量名，commands 是要执行的命令。commands 可以只有一个命令，也可以有多个命令，多个命令之间以分号;分隔。
```shell
#!/bin/bash

begin_time=`date` # 开始时间，用反引号替换
sleep 20s
finish_time=$(date) #结束时间，用$()替换

echo "Begin time ${begin_time}"
echo "Finish time ${finish_time}"

```
```shell
[root@zntsa 3.Shell命令替换]# sh code1.sh 
Begin time Tue Mar 21 14:41:08 CST 2023
Finish time Tue Mar 21 14:41:28 CST 2023

```
使用 data 命令的%s格式控制符可以得到当前的 UNIX 时间戳，这样就可以直接计算脚本的运行时间了。UNIX 时间戳是指从 1970 年 1 月 1 日 00:00:00 到目前为止的秒数
```shell
#!/bin/bash

begin_time=`date +%s` # 开始时间，用反引号替换
sleep 20s
finish_time=$(date +%s) #结束时间，用$()替换
run_time=$((finish_time-begin_time))
echo "Begin time ${begin_time}"
echo "Finish time ${finish_time}"
echo "run time:${run_time}s"


```
```shell
[root@zntsa 3.Shell命令替换]# sh code2.sh 
Begin time 1679381124
Finish time 1679381144
run time:20s

```
代码中的`(())`其实是Shell中的数学计算命令。和C++、Java等编程语言不同，在Shell中计算数据没那么方便，必须使用专门的数学计算命令，`(())`就是其中之一。

注意，如果被替换的命令的输出内容包括多行（也即有换行符），或者含有多个连续的空白符，那么在输出变量时应该将变量用双引号包围，否则系统会使用默认的空白符来填充，这会导致换行无效，以及连续的空白符被压缩成一个。请看下面的代码：
```shell
#!/bin/bash

LSL=`ls -l`
echo $LSL  # 不使用双引号包裹
echo "----------------------------"
echo "$LSL"
```
```shell
# 运行结果
total 16 -rw-r--r-- 1 root root 194 Mar 21 14:42 code1.sh -rw-r--r-- 1 root root 267 Mar 21 14:46 code2.sh -rw-r--r-- 1 root root 111 Mar 21 2023 code3.sh -rw-r--r-- 1 root root 1884 Mar 21 2023 note.md
----------------------------
total 16
-rw-r--r-- 1 root root  194 Mar 21 14:42 code1.sh
-rw-r--r-- 1 root root  267 Mar 21 14:46 code2.sh
-rw-r--r-- 1 root root  111 Mar 21  2023 code3.sh
-rw-r--r-- 1 root root 1884 Mar 21  2023 note.md
```
所以建议在输出变量的时候，加上双引号。
# 再谈反引号和$()
原则上来讲，上面提到的两种形式是等价的，可以随意使用；但是反引号毕竟看起来像单引号，有时候会对查看代码造成困扰，而使用`$()`则更加清晰，能有效避免这种混乱。
而且有些情况必须使用$():因为$()支持嵌套，反引号不行。

下面的例子演示了使用计算 ls 命令列出的第一个文件的行数，这里使用了两层嵌套。
```shell
[c.biancheng.net]$ Fir_File_Lines=$(wc -l $(ls | sed -n '1p'))
[c.biancheng.net]$ echo "$Fir_File_Lines"
36 anaconda-ks.cfg
```
要注意的是，$() 仅在 Bash Shell 中有效，而反引号可在多种 Shell 中使用。所以这两种命令替换的方式各有特点，究竟选用哪种方式全看个人需求。
