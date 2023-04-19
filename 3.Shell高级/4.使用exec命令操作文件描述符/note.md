# 使用exec命令操作文件描述符
exec 是 Shell 内置命令，它有两种用法，一种是执行 Shell 命令，一种是操作文件描述符。本节只讲解后面一种，前面一种请大家自行学习。

使用exec命令可以永久地重定向，后续命令的输入输出方向也被确定了，直到再次遇到exec命令才会改变重定向的方向；换句话说，一次重定向，永久有效。

所以我们之前使用的重定向都是临时的，只是对当前的命令有效，对后面的命令无效。

请看下面的例子
```shell
[root@zntsa 4.使用exec命令操作文件描述符]# echo "c.biancheng.net" > log.txt
[root@zntsa 4.使用exec命令操作文件描述符]# echo "C语言中文网"
C语言中文网
[root@zntsa 4.使用exec命令操作文件描述符]# cat log.txt 
c.biancheng.net
[root@zntsa 4.使用exec命令操作文件描述符]# 
```
其中第一个echo命令使用了重定向，将内容输出到log.txt文件；第二个echo命令没有再次使用重定向，内容就直接输出到显示器上了。
很明显，重定向只对第一个echo命令有效，对第二个echo命令无效。

有些脚本文件的输出内容很多，我们不希望直接输出到显示器上，或者我们需要把输出内容备份到文件中，方便以后检索，按照以前的思路，必须在每个命令后面都使用一次重定向，写起来非常麻烦。如果以后想修改重定向的方向，那工作量也是不小的。

exec 命令就是为解决这种困境而生的，它可以让重定向对当前 Shell 进程中的所有命令有效，它的用法为：
```shell
exec 文件描述符操作
```

所有对文件描述符的操作方式 exec 都支持，请看下面的例子：
```shell
[root@zntsa 4.使用exec命令操作文件描述符]# echo "重定向未发生"
重定向未发生
[root@zntsa 4.使用exec命令操作文件描述符]# exec >log.txt
[root@zntsa 4.使用exec命令操作文件描述符]# echo "c.biancheng.net"
[root@zntsa 4.使用exec命令操作文件描述符]# echo "C语言中文网"
[root@zntsa 4.使用exec命令操作文件描述符]# exec >&2
[root@zntsa 4.使用exec命令操作文件描述符]# echo "重定向已恢复"
重定向已恢复
[root@zntsa 4.使用exec命令操作文件描述符]# cat log.txt 
c.biancheng.net
C语言中文网
```
对代码的说明：
+ `exec >log.txt`将当前 Shell 进程的所有标准输出重定向到 log.txt 文件，它等价于`exec 1>log.txt`。
+ 后面的两个 echo 命令都没有在显示器上输出，而是输出到了 log.txt 文件。
+ `exec >&2`用来恢复重定向，让标准输出重新回到显示器，它等价于`exec 1>&2`。2 是标准错误输出的文件描述符，
它也是输出到显示器，并且没有遭到破坏，我们用 2 来覆盖 1，就能修复 1，让 1 重新指向显示器。
+ 接下来的 echo 命令将结果输出到显示器上，证明`exec >&2`奏效了。
+ 最后我们用 cat 命令来查看 log.txt 文件的内容，发现就是中间两个 echo 命令的输出。

# 重定向的恢复
类似`echo "1234" >log.txt`这样的重定向只是临时的当前命令执行完毕后，会自动恢复到显示器，我们不用担心。
但是如果使用了诸如`exec >log.txt`这种使用exec命令的重定向都是持久的，如果我们想回到显示器，就必须手动恢复。

以输出重定向为例，手动恢复的方法有两种：
+ /dev/tty 文件代表的就是显示器，将标准输出重定向到 /dev/tty 即可，也就是 exec >/dev/tty。
+ 如果还有别的文件描述符指向了显示器，那么也可以别的文件描述符来恢复标号为 1 的文件描述符，例如 exec >&2。注意，如果文件描述符 2 也被重定向了，那么这种方式就无效了。

下面的例子演示了输入重定向的恢复：
```shell
#!/bin/bash

exec 6<&0 #先将0号文件描述符(也就是标准输入）保存起来
exec <nums.txt # 输入重定向

sum=0
while read n; do
  ((sum += n))
done

echo "sum=$sum"

exec 0<&6 6<&-  #恢复输入重定向，并关闭文件描述符6

read -p "请输入名字、网址和年龄：" name url age
echo "$name已经$age岁了，它的网址是 $url"
```
创建一个nums.txt，写入一些数据，之后执行Shell脚本
```shell
[mozhiyan@localhost ~]$ cat nums.txt
80
33
129
71
100
222
8
[mozhiyan@localhost ~]$ bash ./test.sh
sum=643
请输入名字、网址和年龄：C语言中文网 http://c.biancheng.net 7
C语言中文网已经7岁了，它的网址是 http://c.biancheng.net
```
