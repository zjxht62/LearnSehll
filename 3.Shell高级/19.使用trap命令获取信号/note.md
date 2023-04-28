# Linux Shell trap命令：捕获信号
之前我们写的脚本中还没有需要进行信号处理的，因为它们的内容相对简单，执行时间也很短，而且不会创建临时文件。而对于较大的或者是更复杂的脚本来说，
如果脚本具有信号处理机制可能就比较有用了。

当我们设计一个大且复杂的脚本时，考虑到当脚本运行时出现用户退出或者系统关机会发生什么事很重要的。当这样的事件发生时，一个信号将会发送到所有受影响的进程。
相应的，这些进程的程序可以采取一些措施以确保程序正常有序地终结。比如说，我们编写了一个会在执行时生成临时文件的脚本。在好的设计过程中，我们会让脚本在执行完成时删除这些文件。
同样聪明的做法是，如果脚本接收到了指定程序将提前结束的信号，也应删除这些临时文件。

# trap命令
Bash Shell的内部命令trap让我们可以在Shell脚本内捕获特定信号并对它们进行处理。trap命令的语法如下所示：
```shell
trap command signal [signal ...]
```
上述语法中，command可以是一个脚本或者是一个函数。signal既可以用信号名，也可以用信号值来指定。

你可以不指定任何参数，而直接使用trap命令，它将会打印与每个要捕获的信号相关联的命令的列表。

当Shell收到信号signal(s)时，command将被读取和执行。比如，如果signal是0或者EXIT时，command会在Shell退出时被执行。如果signal是DEBUG时，command会在每个命令后被执行。

signal也可以被指定为ERR，那么每当一个命令以非0状态退出时，command就会被执行（注意，当非 0 退出状态来自一个 if 语句部分，或来自 while、until 循环时，command 不会被执行）。

下面我们通过几个简单的实例来学习 trap 命令的用法。

首先，我们定义一个变量FILE:
```shell
FILE=`mktemp -u /tmp/testtrap.$$.XXXXXX`
```
这里使用mktemp命令创建一个临时文件；使用`-u`选项，表示并不真正创建文件，只是打印生成的文件名；`XXXXXX`表示生成6位随机字符。

然后，我们定义捕获错误信号：
```shell
trap "echo There exist come error\!" ERR
```

查看已经定义的捕获：
```shell
[root@zntsa 19.使用trap命令获取信号]# trap
trap -- '' SIGQUIT
trap -- '' SIGTERM
trap -- '' SIGTSTP
trap -- '' SIGTTIN
trap -- '' SIGTTOU
trap -- 'echo There exist come error\!' ERR
```
此时，当我们尝试使用 rm 命令删除变量 $FILE 代表的并不存在的文件时，就会显示类似如下的错误信息：
```shell
[root@zntsa 19.使用trap命令获取信号]# rm $FILE
rm: cannot remove ‘/tmp/testtrap.22155.lCtJz7’: No such file or directory
There exist come error!
```
从上面的输出中我们看到，Shell捕获到了文件`/tmp/testtrap.22155.lCtJz7`不存在这个错误信号，并执行了echo命令，显示了我们指定的错误信息。

当调试较大的脚本时，你可能想要赋予某个变量一个跟踪属性，并捕获变量的调试信息。通常，你可能只使用一个简单的赋值语句，比如，VARIABLE=value，来定义一个变量。
若使用类似如下的雨具替换上述的变量定义，可能会为你提供更有用的调试信息。
```shell
#声明变景 VARIABLE，并赋予其踪迹属性
declare -t VARIABLE=value
#捕获DEBUG
trap "echo VARIABLE is being used here." DEBUG
#脚本的余下部分
```

现在，我们创建一个名称为 testtrap1.sh 的脚本，其内容如下所示：
```shell
#!/bin/bash
# 捕获退出状态0
trap 'echo "Exit 0 signal detected..."' 0

# 打印信息
echo "This script is used for testing trap command."

#以状态（信号）0 退出此 Shell 脚本
exit 0
```
此脚本运行结果将类似如f所示：
```shell
[root@zntsa 19.使用trap命令获取信号]# sh testtrap1.sh 
This script is used for testing trap command.
Exit 0 signal detected...
```
在上述的脚本中，trap 命令语句设置了一个当脚本以 0 状态退出时的捕获，所以当脚本以 0 状态退出时，会打印一条信息“Exit 0 signal detected...”。

我们再创建一个名称为 testtrap2.sh 的脚本，其内容类似如下所示：
```shell
#!/bin/bash

#捕获信号 SIGINT，然后打印相应信息
trap "echo 'You hit control+C! I am ignoring you.'" SIGINT

#捕获信号 SIGTERM，然后打印相应信息
trap "echo 'You tried to kill me! I am ignoring you.'" SIGTERM

#循环5次
for i in {1..5} ; do
    echo "Iteration $i of 5"
    # 暂停5秒
    sleep 5
done
```
当运行上述脚本时，如果敲击CTRL+C组合键，将会中断sleep命令，进入下一次循环，并看到输出信息`You hit control+C! I am ignoring you.`，
但脚本 testtrap2.sh 并不会停止运行。此脚木的运行结果将类似如下所示：
```shell
[root@zntsa 19.使用trap命令获取信号]# sh testtrap2.sh 
Iteration 1 of 5
Iteration 2 of 5
^CYou hit control+C! I am ignoring you.
Iteration 3 of 5
^CYou hit control+C! I am ignoring you.
Iteration 4 of 5
^CYou hit control+C! I am ignoring you.
Iteration 5 of 5
```

当将上述脚本放在后台运行时，如果我们同时在另一个终端窗口尝试使用 kill 命令终结此脚木，此脚本并不会被终结，而是会显示信息“You tried to kill me! I am ignoring you.”， 
， 此脚本的运行结果将会类似如下所示：
```shell
[c.biancheng.net]$ sh ./testtrap2.sh &
[1] 2320
[c.biancheng.net]$ Iteration 1 of 5
You tried to kill me! I am ignoring you.
Iteration 2 of 5
Iteration 3 of 5
Iteration 4 of 5
You tried to kill me! I am ignoring you.
Iteration 5 of 5
You tried to kill me! I am ignoring you.
[1]+ Done    sh ./testtrap2.sh
```
有时，接收到一个信号后你可能不想对其做任何处理。比如，当你的脚本处理较大的文件时，你可能希望阻止一些错误地输入Ctrl+C或Ctrl+\组合键的做法，并且希望它能执行完成而不是被用户中断。
这时就可以使用空字符串`""`或者`''`作为trap的命令参数，那么Shell将忽略这些信号。其用法类似如下所示：
```shell
$ trap ' ' SIGHUP SIGINT [ signal... ]
```