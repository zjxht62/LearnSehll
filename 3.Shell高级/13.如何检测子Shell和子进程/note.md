# 如何检测子Shell和子进程
我们知道，使用$变量可以获取当前进程的id，我在父Shell和子Shell中都输出$的值，只要它们不一样，不就是创建了一个新的进程么？（但是这里有坑）先试一下。
```shell
[root@zntsa ~]# echo $$  # 父Shell的PID
12730
[root@zntsa ~]# (echo $$)  # 组命令形式的子Shell PID
12730
[root@zntsa ~]# echo "http://c.biancheng.net" | { echo $$; } # 管道形式的子Shell PID
12730
[root@zntsa ~]# read < <(echo $$)  # 进程替换形式的子Shell PID
[root@zntsa ~]# echo $REPLY
12730
```
这里，子Shell和父Shell的PID竟然是一样的，看着好像没有产生新进程。

根本原因是因为**$变量在子Shell中无效**， Bash官方文档说，在普通的子进程中，$确实被展开为子进程的ID；但是在子Shell中，$却被展开成父进程的ID。

除了$，Bash还提供了另外两个环境变量--SHLVL和BASH_SUBSHELL，用它们来检测子Shell非常方便。

SHLVL 是记录多个 Bash 进程实例嵌套深度的累加器，每次进入一层普通的子进程，SHLVL 的值就加 1。
而 BASH_SUBSHELL 是记录一个 Bash 进程实例中多个子 Shell（sub shell）嵌套深度的累加器，每次进入一层子 Shell，BASH_SUBSHELL 的值就加 1。

1) 我们还是用实例来说话吧，先说 SHLVL。创建一个脚本文件，命名为 test.sh，内容如下：
```shell
#!/bin/bash
echo $SHLVL $BASH_SUBSHELL
```
然后打开Shell窗口，依次执行下面的命令：
```shell
[root@zntsa 13.如何检测子Shell和子进程]# echo "$SHLVL $BASH_SUBSHELL"
1 0
[root@zntsa 13.如何检测子Shell和子进程]# bash  # 使用bash命令开启一个新的Shell会话
[root@zntsa 13.如何检测子Shell和子进程]# echo "$SHLVL $BASH_SUBSHELL" # 可见SHLVL加1，说明又进入了一个子进程
2 0
[root@zntsa 13.如何检测子Shell和子进程]# bash ./test.sh #通过bash命令运行脚本，此脚本又进入了一层子进程，所以SHLVL再加1
3 0
[root@zntsa 13.如何检测子Shell和子进程]# echo "$SHLVL $BASH_SUBSHELL" # 脚本执行完，回到上一层，所以SHLVL还是2
2 0
[root@zntsa 13.如何检测子Shell和子进程]# chmod +x ./test.sh #给脚本增加执行权限
[root@zntsa 13.如何检测子Shell和子进程]# ./test.sh 
3 0
[root@zntsa 13.如何检测子Shell和子进程]# echo "$SHLVL $BASH_SUBSHELL"
2 0
[root@zntsa 13.如何检测子Shell和子进程]# exit #退出内层Shell
exit
[root@zntsa 13.如何检测子Shell和子进程]# echo "$SHLVL $BASH_SUBSHELL"
1 0

```
SHLVL 和 BASH_SUBSHELL 的初始值都是 0，但是输出结果中 SHLVL 的值从 2 开始，我猜测 Bash 在初始化阶段可能创建了子进程，我们暂时不用理会它，
将关注点放在值的变化上。

仔细观察的读者应该会发现，使用 bash 命令开启新的会话后，需要使用 exit 命令退出才能回到上一级 Shell 会话。

`bash ./test.sh`和`chmod+x ./test.sh;./test.sh`这两种运行脚本的方式，在脚本运行期间会开启一个子进程，运行结束后立即退出子进程。

2) 再说一下 BASH_SUBSHELL，请看下面的命令：
```shell
[root@zntsa 13.如何检测子Shell和子进程]# echo "$SHLVL $BASH_SUBSHELL"
1 0
[root@zntsa 13.如何检测子Shell和子进程]# ( echo "$SHLVL $BASH_SUBSHELL" ) # 组命令
1 1
[root@zntsa 13.如何检测子Shell和子进程]# echo "hello" | { echo "$SHLVL $BASH_SUBSHELL"; } # 管道
1 1
[root@zntsa 13.如何检测子Shell和子进程]# var=$(echo "$SHLVL $BASH_SUBSHELL";) # 命令替换
[root@zntsa 13.如何检测子Shell和子进程]# echo $var 
1 1
[root@zntsa 13.如何检测子Shell和子进程]# ( ( ( ( echo "$SHLVL $BASH_SUBSHELL" ) ) ) ) # 四层组命令
1 4
```
可见，组命令、管道、命令替换这几种写法都会进入子Shell

注意，“进程替换”看起来好像产生了一个子Shell，其实只是玩了一个障眼法而已。进程替换只是借助文件在`()`内部和外部命令之间传递数据，但是它并没有创建子Shell；
换句话说，`()`内部和外部的命令是在一个进程（也就是当前进程）中执行的

我们可以测试一下
```shell
[root@zntsa 13.如何检测子Shell和子进程]# echo "$SHLVL $BASH_SUBSHELL"
1 0
[root@zntsa 13.如何检测子Shell和子进程]# echo "hello" > >(echo "$SHLVL $BASH_SUBSHELL")
1 0
```
SHLVL 和 BASH_SUBSHELL 变量的值都没有发生改变，说明进程替换既没有进入子进程，也没有进入子 Shell。
