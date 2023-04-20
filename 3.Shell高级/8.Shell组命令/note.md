# Shell组命令（把多条命令看做一个整体）
所谓组命令，就是将多个命令划分为一组，或者看成一个整体

Shell组命令的写法有两种：
```shell
{ command1;command2;command3;... }
(command1;command2;command3;...)
```
这两者的区别在于，由花括号`{}`包围起来的组命令在当前Shell进程中执行，而小括号`()`包围起来的组命令会创建一个子Shell，所有命令都在子Shell中执行。

对于第一种写法，花括号和命令之间**必须有一个空格**，并且**最后一个命令必须用一个分号或者一个换行符结束**。

子Shell就是一个子进程，是通过当前Shell进程创建的一个新进程。但是子Shell和一般的子进程（比如`bash ./test.sh`创建的子进程）还是有区别的，
我们将在《子Shell和子进程》一节中深入讲解，读者暂时把子 Shell 和子进程等价起来就行。

**组命令可以将多条命令的输出结果合并在一起，在使用重定向和管道时会特别方便。**

例如，下面的代码将多个命令的输出重定向到 out.txt：
```shell
ls -l > out.txt  #>表示覆盖
echo "http://c.biancheng.net/shell/" >> out.txt  #>>表示追加
cat readme.txt >> out.txt
```
本段代码共使用了三次重定向。

借助组命令，我们可以将以上三条命令合并在一起，简化成一次重定向：
```shell
{ ls -l; echo "http://c.biancheng.net/shell/"; cat readme.txt; } > out.txt
```
或者写作：
```shell
(ls -l; echo "http://c.biancheng.net/shell/"; cat readme.txt) > out.txt
```
使用组命令技术，我们节省了一些打字时间。

类似的道理，我们也可以将组命令和管道结合起来：
```shell
{ ls -l; echo "http://c.biancheng.net/shell/"; cat readme.txt; } | lpr
```
这里我们把三个命令的输出结果合并在一起，并把它们用管道输送给命令 lpr 的输入，以便产生一个打印报告。

# 两种组命令形式的对比
虽然两种Shell组命令形式看起来很相似，它们都能用在重定向中合并输出结果，但是两者之间有一个很重要的不同：由`{}`包围的组命令在当前Shell进程中进行，
由`()`包围的组命令会创建一个子Shell，所有的命令都会在这个子Shell中执行。

在子Shell中执行意味着，运行环境被复制给了一个新的shell进程，当这个子Shell退出时，新的进程也会被销毁，环境副本也会消失，
所以在子Shell环境中的任何更改都会消失（包括给变量赋值）。因此，在大多数情况下，除非脚本要求一个子Shell，否则使用`{}`比使用`()`更受欢迎，
并且`{}`的进行速度更快，占用的内存更少。
