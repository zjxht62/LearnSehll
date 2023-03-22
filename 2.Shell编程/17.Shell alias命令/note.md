# Shell alias：给命令创建别名
alisa 用来给命令创建一个别名。若直接输入该命令且不带任何参数，则列出当前 Shell 进程中使用了哪些别名。现在你应该能理解类似`ll`这样的命令为什么与`ls -l`的效果是一样的吧。

下面让我们来看一下有哪些命令被默认创建了别名：
```shell
[root@zntsa 15.Shell关联数组]# alias
alias cp='cp -i'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias mv='mv -i'
alias rm='rm -i'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
```
Shell 会给某些命令默认创建别名。

# 使用 alias 命令自定义别名
使用 alias 命令自定义别名的语法格式为：
```shell
alias new_name='command'
```
比如，一般的关机命令是`shutdown-h now`，写起来比较长，这时可以重新定义一个关机命令，以后就方便多了。
```shell
alias myShutdown='shutdown -h now'
```
再如，通过 date 命令可以获得当前的 UNIX 时间戳，具体写法为`date +%s`，如果你嫌弃它太长或者不容易记住，那可以给它定义一个别名。
```shell
alias timestamp='date +%s'
```
通过使用alias，可以简化之前的代码
```shell
#!/bin/bash
 
alias timestamp='date +%s'

begin=`timestamp`
sleep 10s
finish=$(timestamp)
difference=$((finish - begin))

echo "run time is : ${difference}s"
```
运行脚本，20 秒后看到输出结果：  
run time: 20s

**别名只是临时的**

在代码中使用 alias 命令定义的别名只能在当前 Shell 进程中使用，在子进程和其它进程中都不能使用。当前 Shell 进程结束后，别名也随之消失。

要想让别名对所有的 Shell 进程都有效，就得把别名写入 Shell 配置文件。Shell 进程每次启动时都会执行配置文件中的代码做一些初始化工作，将别名放在配置文件中，那么每次启动进程都会定义这个别名。

# 使用 unalias 命令删除别名
使用 unalias 内建命令可以删除当前 Shell 进程中的别名。unalias 有两种使用方法：
+ 第一种用法是在命令后跟上某个命令的别名，用于删除指定的别名。
+ 第二种用法是在命令后接-a参数，删除当前 Shell 进程中所有的别名。

同样，这两种方法都是在当前 Shell 进程中生效的。要想永久删除配置文件中定义的别名，只能进入该文件手动删除。
```shell
# 删除 ll 别名
[mozhiyan@localhost ~]$ unalias ll
# 再次运行该命令时，报“找不到该命令”的错误，说明该别名被删除了
[mozhiyan@localhost ~]$ ll
-bash: ll: command not found
```