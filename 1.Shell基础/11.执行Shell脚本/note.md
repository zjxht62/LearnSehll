# 执行Shell脚本

运行 Shell 脚本有两种方法，一种在新进程中运行，一种是在当前 Shell 进程中运行。

# 在新进程中运行Shell脚本
在新进程中运行 Shell 脚本有多种方法。

**1)将 Shell 脚本作为程序运行**

Shell 脚本也是一种解释执行的程序，可以在终端直接调用（需要使用 chmod 命令给 Shell 脚本加上执行权限），如下所示：
```shell
[mozhiyan@localhost ~]$ cd demo                #切换到 test.sh 所在的目录
[mozhiyan@localhost demo]$ chmod +x ./test.sh  #给脚本添加执行权限
[mozhiyan@localhost demo]$ ./test.sh           #执行脚本文件
Hello World !                                  #运行结果
```
第 2 行中，`chmod +x`表示给 test.sh 增加执行权限。

第 3 行中，`./`表示当前目录，整条命令的意思是执行当前目录下的 test.sh 脚本。如果不写`./`，Linux 会到系统路径（由 PATH 环境变量指定）下查找 test.sh，而系统路径下显然不存在这个脚本，所以会执行失败。

通过这种方式运行脚本，脚本文件第一行的#!/bin/bash一定要写对，好让系统查找到正确的解释器。

**2)将 Shell 脚本作为参数传递给 Bash 解释器**

你也可以直接运行 Bash 解释器，将脚本文件的名字作为参数传递给 Bash，如下所示：
```shell
[mozhiyan@localhost ~]$ cd demo               #切换到 test.sh 所在的目录
[mozhiyan@localhost demo]$ /bin/bash test.sh  #使用Bash的绝对路径
Hello World !                                 #运行结果
```
通过这种方式运行脚本，不需要在脚本文件的第一行指定解释器信息，写了也没用。

更加简洁的写法是运行 bash 命令。bash 是一个外部命令，Shell 会在 /bin 目录中找到对应的应用程序，也即 /bin/bash，这点我们已在《Shell命令的本质到底是什么》一节中提到。
```shell
[mozhiyan@localhost ~]$ cd demo
[mozhiyan@localhost demo]$ bash test.sh
Hello World !
```
在现代的 Linux 上，sh 已经被 bash 代替，`/bin/sh`往往是指向`/bin/bash`的符号链接，所以直接用sh也行，和bash效果一样
```shell
[root@zntsa 10.第一个Shell脚本]# sh test.sh 
Hello World!
```
这两种写法在本质上是一样的：第一种写法给出了绝对路径，会直接运行 Bash 解释器；第二种写法通过 bash 命令找到 Bash 解释器所在的目录，然后再运行，
只不过多了一个查找的过程而已。

**检测是否开启了新进程**

Linux 中的每一个进程都有一个唯一的 ID，称为 PID，使用`$$`变量就可以获取当前进程的 PID。`$$`是 Shell 中的特殊变量，稍后我会在《Shell特殊变量》一节中展开讲解，读者在此不必深究。

首先编写如下的脚本文件，并命名为 check.sh：
```shell
#!/bin/bash
echo $$ # 输出当前进程PID
```
然后使用以上两种方式来运行 check.sh：
```shell
[root@zntsa 11.执行Shell脚本]# echo $$
4296  #当前进程的PID
[root@zntsa 11.执行Shell脚本]# chmod +x check.sh 
[root@zntsa 11.执行Shell脚本]# ./check.sh 
6926  #新进程的PID
[root@zntsa 11.执行Shell脚本]# echo $$
4296  #当前进程的PID
[root@zntsa 11.执行Shell脚本]# /bin/bash check.sh 
6950  #新进程的PID
[root@zntsa 11.执行Shell脚本]# echo $$
4296  #当前进程的PID
[root@zntsa 11.执行Shell脚本]# sh check.sh 
6962  #新进程的PID
```
可见，先`chmod再./执行`，以及`sh+脚本名`都开启了一个新的进程来执行脚本

# 在当前进程中运行 Shell 脚本
这里需要引入一个新的命令——source 命令。**source 是 Shell 内置命令的一种，它会读取脚本文件中的代码，并依次执行所有语句。**
你也可以理解为，source 命令会强制执行脚本文件中的全部命令，而忽略脚本文件的权限。

source 命令的用法为：
```shell
source filename
```
也可以简写为：
```shell
. filename
```
两种写法的效果相同。对于第二种写法，注意点号`.`和文件名中间有一个空格。

例如，使用 source 运行上节的 test.sh：
```shell
[mozhiyan@localhost ~]$ cd demo              #切换到test.sh所在的目录
[mozhiyan@localhost demo]$ source ./test.sh  #使用source
Hello World !
[mozhiyan@localhost demo]$ source test.sh    #使用source
Hello World !
[mozhiyan@localhost demo]$ . ./test.sh       #使用点号
Hello World !
[mozhiyan@localhost demo]$ . test.sh         #使用点号
Hello World !
```
你看，使用 source 命令`不用给脚本增加执行权限`，并且写不写`./`都行，是不是很方便呢？

**检测是否在当前 Shell 进程中**

我们仍然借助`$$`变量来输出进程的 PID，如下所示：
```shell
[root@zntsa 11.执行Shell脚本]# echo $$
4296  #当前进程PID
[root@zntsa 11.执行Shell脚本]# source check.sh 
4296 #Shell脚本所在进程PID
[root@zntsa 11.执行Shell脚本]# . check.sh 
4296 #Shell脚本所在进程PID
```
可见三次执行出现的PID相同，所以均在同一个进程中。
