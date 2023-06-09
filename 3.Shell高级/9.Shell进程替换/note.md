# Shell进程替换（把一个命令的输出传递给另一个命令）
进程替换和命令替换非常类似。命令替换是把一个命令的输出结果赋值给另一个变量，比如dir_files=&#96;ls -l&#96;或者`date_time=$(date)`;
而进程替换则是把一个命令的输出结果传递给另一个（组）命令。

为了说明进程替换的必要性，我们先来看一个使用管道的例子：
```shell
echo "http://c.biancheng.net/shell/" | read
echo $REPLY
```
以上代码输出结果总是为空，因为 echo 命令在父 Shell 中执行，而 read 命令在子 Shell 中执行，当 read 执行结束时，子 Shell 被销毁，
REPLY 变量也就消失了。管道中的命令总是在子 Shell 中执行的，任何给变量赋值的命令都会遭遇到这个问题。

> 使用 read 读取数据时，如果没有提供变量名，那么读取到的数据将存放到环境变量 REPLY 中，这一点已在《Shell read》中讲到。

幸运的是，Shell 提供了一种“特异功能”，叫做进程替换，它可以用来解决这种麻烦。

Shell 进程替换有两种写法，一种用来产生标准输出，借助输入重定向，它的输出结果可以作为另一个命令的输入：
```shell
<(commands)
```
另一种用来接受标准输入，借助输出重定向，它可以接收另一个命令的输出结果：
```shell
>(commands)
```
commands 是一组命令列表，多个命令之间以分号`;`分隔。注意，`<`或`>`与圆括号之间是没有空格的。

例如，为了解决上面遇到的问题，我们可以像下面这样使用进程替换：
```shell
[root@zntsa 8.Shell组命令]# read < <(echo "http")
[root@zntsa 8.Shell组命令]# echo $REPLY
http
```
输出结果：
```shell
http
```
整体上来看，Shell 把`echo "http://c.biancheng.net/shell/"` 的输出结果作为 read 的输入。`<()`用来捕获 echo 命令的输出结果，`<`用来将该结果重定向到 read。

注意，两个`<`之间是有空格的，第一个`<`表示输入重定向，第二个`<`和`()`连在一起表示进程替换。

本例中的 read 命令和第二个 echo 命令都在当前 Shell 进程中运行，读取的数据也会保存到当前进程的 REPLY 变量，大家都在一个进程中，所以使用 echo 能够成功输出。

而在前面的例子中我们使用了管道，echo 命令在父进程中运行，read 命令在子进程中运行，读取的数据也保存在子进程的 REPLY 变量中，
echo 命令和 REPLY 变量不在一个进程中，而子进程的环境变量对父进程是不可见的，所以读取失败。

再来看一个进程替换用作「接受标准输入」的例子：
```shell
echo "C语言中文网" > >(read; echo "你好, $REPLY")
```
运行结果；
```shell
你好, C语言中文网
```
因为使用了重定向，read 命令从`echo "C语言中文网"`的输出结果中读取数据。

# Shell进程替换的本质
为了能够在不同进程之间传递数据，实际上进程替换会跟系统中的文件关联起来，这个文件的名字为`dev/df/n`（n是一个整数）。该文件会作为参数传递给`()`中的命令，
`()`中的命令对该文件是读取还是写入取决于进程替换的格式是`<`还是`>`
+ 如果是`>()`，那么该文件会给`()`中的命令提供输入；借助输出重定向，要输入的内容可以从其它命令而来。
+ 如果是`<()`，那么该文件会接收`()`中命令的输出结果；借助输入重定向，可以将该文件的内容作为其它命令的输入。

使用 echo 命令可以查看进程替换对应的文件名：
```shell
[root@vultr ~]# echo >(true)
/dev/fd/63
[root@vultr ~]# echo <(true)
/dev/fd/63
[root@vultr ~]# echo >(true) <(true)
/dev/fd/63 /dev/fd/62
```
`/dev/fd/`目录下有很多序号文件，进程替换一般用的是 63 号文件，该文件是系统内部文件，我们一般查看不到。

我们通过下面的语句进行实例分析：
```shell
echo "shellscript" > >(read;echo "hello,$REPLY")
```
第一个`>`表示输出重定向，它把第一个echo命令的输出结果重定向到`dev/fd/63`文件中。

`>()`中的第一个命令是read，它需要从标准输入中读取数据，此时就用`/dev/fd/63`作为输入文件，把该文件的内容交给read命令，接着使用echo命令输出read读取到的内容。

可以看到，`/dev/fd/63`文件起到了数据中转或者数据桥梁的作用，借助重定向，它将`>()`内部的命令和外部的命令联系起来，使得数据能够在这些命令之间流通。
