# Shell代码块重定向（对一组命令进行重定向）
所谓代码块，就是由多条语句组成的一个整体；for、while、until循环、或者if...else、case...in选择结构，或者由`{}`包围的命令都可以称之为代码块。

将重定向命令放在代码块的结尾处，就可以对代码块中的所有命令实施重定向。

【实例1】使用 while 循环不断读取 nums.txt 中的数字，计算它们的总和。
```shell
#!/bin/bash

sum=0
while read n; do
  ((sum+=n))
done <nums.txt #输入重定向
echo "sum=$sum"
```
将代码保存，创建num.txt，执行代码
```shell
[root@zntsa 5.Shell代码块重定向]# cat nums.txt 
80
33
129
71
100
222
8
[root@zntsa 5.Shell代码块重定向]# sh code1.sh 
sum=643
```
对上面的代码进行改进，记录 while 的读取过程，并将输出结果重定向到 log.txt 文件：
```shell

sum=0
while read n; do
  ((sum+=n))
  echo "this number: $n"
done <nums.txt >log.txt #同时使用输入重定向合输出重定向
echo "sum=$sum"
```
将代码保存，创建num.txt，执行代码
```shell
[root@zntsa 5.Shell代码块重定向]# sh code2.sh 
sum=643
[root@zntsa 5.Shell代码块重定向]# cat log.txt 
this number: 80
this number: 33
this number: 129
this number: 71
this number: 100
this number: 222
this number: 8
```
【实例2】对{}包围的代码使用重定向。
```shell
#!/bin/bash

{
  echo "C语言中文网";
  echo "http://c.biancheng.net";
  echo "7"
} >log.txt

{
    read name;
    read url;
    read age
} <log.txt  #输入重定向
echo "$name已经$age岁了，它的网址是 $url"
```
运行结果：
```shell
[root@zntsa 5.Shell代码块重定向]# sh code3.sh 
C语言中文网已经7岁了，它的网址是 http://c.biancheng.net
[root@zntsa 5.Shell代码块重定向]# cat log.txt 
C语言中文网
http://c.biancheng.net
7
```