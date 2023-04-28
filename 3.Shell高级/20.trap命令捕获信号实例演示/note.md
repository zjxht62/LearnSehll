# Linux Shell trap命令捕获信号实例演示

通过前面内容的学习，我们已经直到，信号多用于以友好的方式结束一个进程的执行，即允许进程在退出之前有机会做一些清理工作。然而，信号同样还可用于其他用途。
例如，当终端窗口的大小改变时，在此窗口中运行的Shell都会接到信号SIGWINCH。通常，这个信号是被忽略的，但是，如果一个程序关心窗口大小的变化，它就可以捕获这个信号，
并用特定的方式处理它。

> 注意：除 SIGKILL 信号以外，其他任何信号都可以被捕获并通过调用C语言函数 signal 处理。

接下来，我就以一个脚本为实例演示捕获并处理 SIGWINCH 信号。我们创建名为 sigwinch_handler.sh 的脚本，其内容如下所示：
```shell
#!/bin/bash
#打印信息
echo "Adjust the size of your window now."
#捕获SIGWINCH信号
trap "echo Window size changed." SIGWINCH
#定义变量
COUNT=0
#while循环30次
while [ $COUNT -lt 30 ]; do
    #将COUNT变量的值加1
    COUNT=$(($COUNT + 1))
    #休眠1秒
    sleep 1
done
```
当上述的 Shell 脚本运行时，若改变了此脚本运行所在终端窗口的大小，脚本的进程就会收到 SIGWINCH 信号，从而调用 chwinsize 函数，以作出相应的处理。此脚本的运行结果将类似如下所示：
```shell
[root@zntsa 20.trap命令捕获信号实例演示]# sh sigwinch_handler.sh 
Adjust the size of your window now.
Window size changed.
Window size changed.
Window size changed.
Window size changed.
```
我们知道，在trap命令中，可以调用函数来处理相应的信号。下面我们就以脚本 trapbg_clearup.sh 为例，来进一步学习如何使用 trap 语句调用函数来处理信号，其脚本内容如下所示：
```shell
#!/bin/bash

#捕获INT和QUIT信号，如果收到这两个信号，则执行函数my_exit后退出
trap 'my_exit; exit;' SIGINT SIGQUIT

#捕获HUP信号
trap 'echo Going down on a SIGHUP - signal 1, no exiting...; exit' SIGHUP

# 定义count变量
count=0

# 创建临时文件
tmp_file=`mktemp /tmp/file.$$.XXXXXX`

#定义函数my_exit
my_exit()
{
    echo "You hit Ctrl-C/CtrI-\, now exiting..."
    #清除临时文件
    rm -f $tmp_file >& /dev/null
}

#向临时文件写入信息
echo "Do someting..." > $tmp_file

#执行无限while循环
while :
do
    #休眠1秒
    sleep 1
    #将count变量的值加1
    count=$(expr $count + 1)
    #打印count变量的值
    echo $count
done
```
当上述脚本运行时，接收到 SIGINT 或 SIGQUIT 信号后会调用 my_exit 函数后退出（trap 命令列表中的 exit 命令），my_exit 函数会做一些清理临时文件的操作。我们运行此脚本，然后在另一个终端窗口中查看此脚本创建的临时文件：
```shell
[root@zntsa 19.使用trap命令获取信号]# ls -trl /tmp/ |tail -l
total 8
drwx------ 3 root root 17 Jan 30 15:38 systemd-private-d5874ae4ca89445fa00e25604864732d-cups.service-KqeZEH
-rw-r--r-- 1 root root 89 Apr 24 10:25 ps.output
-rw------- 1 root root 15 Apr 28 11:40 file.27940.23B7sv
```
现在，在脚本运行的终端窗口，我们输入 Ctrl+C 或 Ctrl+\ 组合键来终结或退出此脚本， 将会看到类似如下的信息：
```shell
32
33
^CYou hit Ctrl-C/CtrI-\, now exiting...
```
然后我们再查看一下脚本创建的临时文件是否巳被清理：
```shell
[root@zntsa 19.使用trap命令获取信号]# ls -l /tmp/file.27940.23B7sv
ls: cannot access /tmp/file.27940.23B7sv: No such file or directory
```
当脚本运行在后台时，同样可以捕获信号。我们将上例中的脚本 trapbg_clearup.sh 放在后台运行：
```shell
[root@zntsa 20.trap命令捕获信号实例演示]# sh trapbg_clearup.sh &
[1] 28154
[root@zntsa 20.trap命令捕获信号实例演示]# 1
2
3
4

```
现在从另一个终端窗口，发送 HUP 信号来杀掉这个运行脚本的进程：
```shell
[root@zntsa 19.使用trap命令获取信号]# kill -1 28154

```
现在，在脚本运行的终端窗口，将看到类似如下的信息：
```shell
21
22
23
24
25
26
27
Going down on a SIGHUP - signal 1, no exiting...

[1]+  Done                    sh trapbg_clearup.sh
```

# LINENO 和 BASH_COMMAND 变量
Bash Shell中有两个内部变量可以方便地在处理信号时，为我们提供更多的与脚本终结相关的信息。这两个变量分别是LINENO和BASH_COMMAND。BASH_COMMAND是BASH中特有的。
这两个变量分别用于报告脚本当前执行的行号和脚本当前运行的命令。

下面，我们以脚本 trap_report.sh 为实例，学习如何在脚本中使用变量 LINENO 和 BASH_COMMAND 在脚本终结时为我们提供更多的错误信息，其脚本内容类似如下所示：
```shell
#!/bin/bash
#捕获SIGHUP、SIGINT和SIGQUIT信号。如果收到这些信号，将执行函数my_exit后退出
trap 'my_exit $LINENO $BASH_COMMAND; exit' SIGHUP SIGINT SIGQUIT
#函数my_exit
my_exit()
{
    #打印脚本名称，及信号被捕获时所运行的命令和行号
    echo "$(basename $0) caught error on line : $1 command was: $2"
    #将信息记录到系统日志中
    logger -p notice "script: $(basename $0) was terminated: line: $1, command was $2"
    #其他一些清埋命令
}
#执行无限while循环
while :
do
    #休眠1秒
    sleep 1
    #将变量count的值加1
    count=$(expr $count + 1)
    #打印count变量的值
    echo $count
done
```
当上述脚本运行时，向脚本发送 SIGHUP、SIGINT 和 SIGQUIT 信号后，脚本将会调用 my_exit 函数，此函数将解析参数 $l(LINENO) 和 $2(BASH_COMMAND)，
显示信号被捕获时脚本所运行的命令及其行号，同样 logger 语句会记录信息到日志文件 /var/log/messages 中。如果需要，还可以在此函数中执行一些清理命令，
然后脚本将会退出（trap 命令列表中的 exit 命令）。

此脚木的运行结果将会类似如下所示：
```shell
[root@zntsa 20.trap命令捕获信号实例演示]# sh trap_report.sh 
1
2
^Ctrap_report.sh caught error on line : 1 command was: sleep
```
在 /var/log/messages 文件中，将会看到一条类似如下的记录：
```shell
Apr 28 14:05:15 zntsa root: script: trap_report.sh was terminated: line: 1, command was sleep
```

使用trap语句可以忽略信号。你也可以同样在脚本的一部分中忽略某些信号，然后，当你希望捕获这些信号的时候，可以重新定义它们来采取一些行动。
我们以脚本 trapoff_on.sh 为例，在此脚本中我们将忽略信号 SIGINT 和 SIGQUIT，直到 sleep 命令结束运行后为止。然后当下一个 sleep 命令开始时，
如果接收到终结信号，trap 语句将采取相应的行动。

其脚木的内容如下所示：
```shell
#!/bin/bash

# 忽略SIGINT和SIGQUIT信号，注意引号之间不能有空格
trap '' SIGINT SIGQUIT

# 打印提示信息
echo "You cannot terminate using ctrl+c or ctrl+\!"

#休眠10秒
sleep 10

#重新捕获SIGINT和SIGQUIT信号。如果捕获到这两个信号，则打印信息后退出
#现在可以中断脚本了
trap 'echo Terminated!; exit' SIGINT SIGQUIT

#打印提示信息
echo "OK! You can now terminate me using those keystrokes"

sleep 10
```
此脚本的运行结果将类似如下所示：
```shell
[root@zntsa 20.trap命令捕获信号实例演示]# sh trapoff_on.sh 
You cannot terminate using ctrl+c or ctrl+\!
^C^C^C^C^C^C^C^COK! You can now terminate me using those keystrokes
^CTerminated!
```