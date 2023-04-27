# Bash Shell中的信号简述

当没有任何捕获时，一个交互式Bash Shell会忽略SIGTERM和SIGQUIT信号。由Bash运行的非内部命令会使用Shell从其父进程继承的信号处理程序。
如果没有启用作业控制，异步执行的命令会忽略除了有这些信号处理程序之外的 SIGINT 和 SIGQUIT 信号。
由于命令替换而运行的命令会忽略键盘产生的作业控制信号SIGTTIN、SIGTTOU 和 SIGTSTP。

默认情况下，Shell 接收到 SIGHUP 信号后会退出。在退出之前，一个交互式的 Shell 会向所有的作业，不管是正在运行的还是已停止的，重新发送 SIGHUP 信号。
对已停止的作业，Shell 还会发送 SIGCONT 信号以确保它能够接收到 SIGHUP 信号。

若要阻止 Shell 向某个特定的作业发送 SIGHUP 信号，可以使用内部命令 disown 将它从作业表中移除，或是用“disown -h”命令阻止 Shell 向特定的作业发送 SIGHUP 信号，
但并不会将特定的作业从作业表中移除。

我们通过如下实例，来了解一下 disown 命令的作用：
```shell
#将 sleep 命令放在后台执行，休眠30秒
[root@zntsa 13.如何检测子Shell和子进程]# sleep 30 &
[1] 13531

#列出当前 Shell 下所有作业的信息
[root@zntsa 13.如何检测子Shell和子进程]# jobs -l
[1]+ 13531 Running                 sleep 30 &

#将作业1从作业表中移除
[root@zntsa 13.如何检测子Shell和子进程]# disown %1

#再次列出当前 Shell 下所有作业的信息
[root@zntsa 13.如何检测子Shell和子进程]# jobs -l

#查找 sleep 进程
[root@zntsa 13.如何检测子Shell和子进程]# ps -ef | grep sleep
root     13531 12730  0 11:23 pts/2    00:00:00 sleep 30
root     13554 12730  0 11:24 pts/2    00:00:00 grep --color=auto sleep

#打印当前 Shell 的进程号
[root@zntsa 13.如何检测子Shell和子进程]# echo $$
12730
```
在上述实例中，我们首先将命令“sleep 30”放在后台运行，此时，我们使用命令“jobs -l”可以看到作业表中有一个正在运行的作业，然后，
我们使用命令“disown %1”将作业1从作业表中移除，再使用命令“jobs -l”会看到作业表中已经没有了作业，但是我们发现其实“sleep 30”这个命令的进程仍然存在。
此时，Shell 若接收到 SIGHUP 信号，它就不会向作业1重新发送 SIGHUP 信号，此时如果我们退出 Shell，这个作业仍将继续运行，而不会被终止。

我们再来看一下命令“disown -h”的用途：
```shell
#将 sleep 命令放在后台执行，休眠30秒
[root@zntsa 13.如何检测子Shell和子进程]# sleep 30 &
[1] 13687

#列出当前 Shell 下所有作业的信息
[root@zntsa 13.如何检测子Shell和子进程]# jobs -l
[1]+ 13687 Running                 sleep 30 &

#阻止 Shell 向作业1发送 SIGHUP 信号
[root@zntsa 13.如何检测子Shell和子进程]# disown -h %1
[root@zntsa 13.如何检测子Shell和子进程]# jobs -l
[1]+ 13687 Running                 sleep 30 &
```
我们看到，在执行了命令“disown -h %1”后，作业1并没有从作业表中移除，但它己经被标记，所以即使 Shell 收到 SIGHUP 信号也不会向此作业发送 SIGHUP 信号。
因此， 如果此时我们退出 Shell，这个作业也仍将继续运行，而不会被终止。

注意：如果使用内部命令 shopt 打开了 Shell 的 huponexit 选项，当一个交互式的登录 Shell 退出时，会向所有的作业发送 SIGHUP 信号。
