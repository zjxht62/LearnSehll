# Shell while 循环详解
while 循环是 Shell 脚本中最简单的一种循环，当条件满足时，while 重复地执行一组语句，当条件不满足时，就退出 while 循环。

Shell while循环的用法如下：
```shell
while condition
do
  statement
done
```
`condition`表示判断条件，`statement`表示要执行的语句（可以多条），`do`和`done`都是Shell中的关键字

while 循环的执行流程为：
+ 先对condition进行判断，如果条件成立，则进入循环，执行while循环体中的语句，也就是do和done之间的语句。这样就完成了一次循环
+ 每一次执行到done的时候，都会重新判断condition是否成立，如果成立，就进入到下一次循环，继续执行do和done之间的语句，如果不成立，就结束整个while循环，
执行done后面的其他Shell代码
+ 如果一开始condition 就不成立，那么就不会进入循环体，do和done之间的语句就没有执行的机会

**注意，在 while 循环体中必须有相应的语句使得 condition 越来越趋近于“不成立”，只有这样才能最终退出循环，否则 while 就成了死循环，会一直执行下去，永无休止。**

while 语句和 if else 语句中的 condition 用法都是一样的，你可以使用 test 或 [] 命令，也可以使用 (()) 或 [[]]

# while 循环举例
【实例1】计算从 1 加到 100 的和。
```shell
#!/bin/bash

i=1
sum=0

#while [[ i -le 100 ]]; do
while ((i<=100)); do
  ((sum += i))
  ((i++))
done
echo "The sum is: $sum"
```
运行结果：
```shell
The sum is: 5050
```
在 while 循环中，只要判断条件成立，循环就会执行。对于这段代码，只要变量 i 的值小于等于 100，循环就会继续。每次循环给变量 sum 加上变量 i 的值，然后再给变量 i 加 1，直到变量 i 的值大于 100，循环才会停止。

`i++`语句使得 i 的值逐步增大，让判断条件越来越趋近于“不成立”，最终退出循环。

对上面的例子进行改进，计算从m加到到n的值
```shell
#!/bin/bash
read m
read n
sum=0
while ((m <= n))
do
    ((sum += m))
    ((m++))
done
echo "The sum is: $sum"
```
运行结果：
```shell
$ sh code2.sh
1
3
The sum is: 6
```
【实例2】实现一个简单的加法器，用户每行输入一个数字，计算所有数字的和
```shell
#!/bin/bash

sum=0

echo "请输入您要计算的数字，按Ctrl+D组合键结束读取"
while read n; do
    ((sum += n))
done

echo "The sum is:$sum"
```
运行结果：
```shell
请输入您要计算的数字，按Ctrl+D组合键结束读取
1
3
4
5
11
The sum is:24
```
在终端中读取数据，可以等价为在文件中读取数据，按下 Ctrl+D 组合键表示读取到文件流的末尾，此时 read 就会读取失败，得到一个非 0 值的退出状态，从而导致判断条件不成立，结束循环。
