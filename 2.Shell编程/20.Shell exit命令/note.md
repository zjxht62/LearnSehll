# Shell exit命令：退出当前进程
exit是一个Shell内置命令，用来退出当前Shell进程，并返回一个退出状态；使用`$?`可以接收这个退出状态

exit命令可以接收一个整数值作为参数，代表退出状态。如果不指定，默认状态值是0。

一般情况下，退出状态为0表示成功，退出状态非0表示执行失败（出错）。

exit 退出状态只能是一个介于 0~255 之间的整数，其中只有 0 表示成功，其它值都表示失败。

Shell 进程执行出错时，可以根据退出状态来判断具体出现了什么错误，比如打开一个文件时，我们可以指定 1 表示文件不存在，2 表示文件没有读取权限，3 表示文件类型不对。

```shell
#!/bin/bash

echo "before exit"
exit 8
echo "after exit"
```
运行脚本：
```shell
[root@zntsa 20.Shell exit命令]# sh code1.sh 
before exit
```
可以看到`after exit`并没有输出，说明遇到exit之后，脚本就执行结束了
> 注意，exit 表示退出当前 Shell 进程，我们必须在新进程中运行 test.sh，否则当前 Shell 会话（终端窗口）会被关闭，我们就无法看到输出结果了。

接下来我们可以使用`$?`来获取退出状态
```shell
[root@zntsa 20.Shell exit命令]# echo $?
8
```
