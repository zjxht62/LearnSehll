# Linux Shell命令的基本格式

进入 Shell 之后第一眼看到的内容类似下面这种形式：
```shell
[mozhiyan@localhost ~]$
```
这叫做**命令提示符**，看见它就意味着可以输入命令了。命令提示符不是命令的一部分，它只是起到一个提示作用，我们将在《Shell命令提示符》一节中详细分析，本节只分析 Shell 命令的基本格式。

Shell 命令的基本格式如下：
```shell
command [选项] [参数]
```

`[]`表示可选的，也就是可有可无。有些命令不写选项和参数也能执行，有些命令在必要的时候可以附带选项和参数。

# 使用选项
可以看到，选项的作用是调整命令功能。如果没有选项，那么命令只能执行最基本的功能；而一旦有选项，则能执行更多功能，或者显示更加丰富的数据。

**短格式选项和长格式选项**

Linux 的选项又分为短格式选项和长格式选项。
+ 短格式选项是长格式选项的简写，用一个减号`-`和一个字母表示，例如`ls -l`。
+ 长格式选项是完整的英文单词，用两个减号`--`和一个单词表示，例如`ls --all`。

**一般情况下，短格式选项是长格式选项的缩写，也就是一个短格式选项会有对应的长格式选项。当然也有例外**，比如 ls 命令的短格式选项-l就没有对应的长格式选项，所以具体的命令选项还需要通过帮助手册来查询。

# 使用参数
参数是命令的操作对象，一般情况下，文件、目录、用户和进程等都可以作为参数被命令操作。例如：
```shell
[mozhiyan@localhost demo]$ ls -l main.c
-rw-rw-r--. 1 mozhiyan mozhiyan 650 4月  10 11:06 main.c
```
但是为什么一开始 ls 命令可以省略参数？那是因为有默认参数。**命令一般都需要加入参数，用于指定命令操作的对象是谁。如果可以省略参数，则一般都有默认参数**。
例如 ls：
```shell
[mozhiyan@localhost ~]$ cd demo
[mozhiyan@localhost demo]$ ls
abc          demo.sh    a.out         demo.txt
getsum       main.sh    readme.txt    a.sh
module.sh    log.txt     test.sh      main.c
```
这个 ls 命令后面如果没有指定参数的话，默认参数是当前所在位置，所以会显示当前目录下的文件名。

**选项和参数一起使用**
Shell 命令可以同时附带选项和参数，例如：
```shell
[mozhiyan@localhost ~]$ echo "http://c.biancheng.net/shell/"
http://c.biancheng.net/shell/
[mozhiyan@localhost ~]$ echo -n "http://c.biancheng.net/shell/"
http://c.biancheng.net/shell/[mozhiyan@localhost ~]$
```
`-n`是 echo 命令的选项，`"http://c.biancheng.net/shell/"` 是 echo 命令的参数，它们被同时用于 echo 命令。

echo 命令用来输出一个字符串，默认输出完成后会换行；给它增加`-n`选项，就不会换行了。

# 选项附带的参数
有些命令的选项后面也可以附带参数，这些参数用来补全选项，或者调整选项的功能细节。

例如，read 命令用来读取用户输入的数据，并把读取到的数据赋值给一个变量，它通常的用法为：
```shell
read str
```
str 为变量名。

如果我们只是想读取固定长度的字符串，那么可以给 read 命令增加`-n`选项。比如读取一个字符作为性别的标志，那么可以这样写：
```shell
read -n 1 sex
```
`1`是`-n`选项的参数，`sex`是 `read` 命令的参数。

`-n`选项表示读取固定长度的字符串，那么它后面必然要跟一个数字用来指明长度，否则选项是不完整的。

# 总结
Shell 命令的选项用于调整命令功能，而命令的参数是这个命令的操作对象。有些选项后面也需要附带参数，以补全命令的功能。

