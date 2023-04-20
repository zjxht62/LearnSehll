# Shell Here String（内嵌字符串，嵌入式字符串）
Here String是Here Document的一个变种，它的用法如下：
```shell
command <<< string
```
command 是 Shell 命令，string 是字符串（它只是一个普通的字符串，并没有什么特别之处）。

这种写法告诉 Shell 把 string 部分作为命令需要处理的数据。例如，将小写字符串转换为大写：
```shell
[root@zntsa 7.Shell Here String]# tr a-z A-Z <<< one
ONE
```
Here String 对于这种发送较短的数据到进程是非常方便的，它比 Here Document 更加简洁。

# 双引号和单引号
一个单词不需要使用引号包围，但如果 string 中带有空格，则必须使用双引号或者单引号包围，如下所示：
```shell
[root@zntsa 7.Shell Here String]# tr a-z A-Z <<< "one two three"
ONE TWO THREE
```
双引号和单引号是有区别的，双引号会解析其中的变量（当然不写引号也会解析），单引号不会，请看下面的代码：
```shell
[root@zntsa 7.Shell Here String]# var=two
[root@zntsa 7.Shell Here String]# tr a-z A-Z <<<"one $var three"
ONE TWO THREE
[root@zntsa 7.Shell Here String]# tr a-z A-Z <<<'one $var three'
ONE $VAR THREE
[root@zntsa 7.Shell Here String]# tr a-z A-Z <<<one${var}three
ONETWOTHREE
```
有了引号的包围，Here String 还可以接收多行字符串作为命令的输入，如下所示：
```shell
[root@zntsa 7.Shell Here String]# tr a-z A-Z <<< "one two three
> four five six
> seven eight"
ONE TWO THREE
FOUR FIVE SIX
SEVEN EIGHT
```
# 总结
与 Here Document 相比，Here String 通常是相当方便的，特别是发送变量内容（而不是文件）到像 grep 或者 sed 这样的过滤程序时。
