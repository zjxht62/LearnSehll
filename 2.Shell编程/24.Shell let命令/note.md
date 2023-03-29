# Shell let命令：对整数进行数学运算
let 命令和双小括号 (( )) 的用法是类似的，它们都是用来对整数进行运算

**注意：和双小括号 (( )) 一样，let 命令也只能进行整数运算，不能对小数（浮点数）或者字符串进行运算。**

Shell let 命令的语法格式为：
```shell
let 表达式
```
或者
```shell
let "表达式"
```
或者
```shell
let '表达式'
```
它们都等价于`((表达式))`。

当表达式中含有 Shell 特殊字符（例如 |）时，需要用双引号`" "`或者单引号`' '`将表达式包围起来。

和 (( )) 类似，let 命令也支持一次性计算多个表达式，并且以最后一个表达式的值作为整个 let 命令的执行结果。但是，对于多个表达式之间的分隔符，let 和 (( )) 是有区别的：
+ let 命令以空格来分隔多个表达式；
+ (( )) 以逗号`,`来分隔多个表达式。

另外还要注意，对于类似`let x+y`这样的写法，Shell 虽然计算了 x+y 的值，但却将结果丢弃；若不想这样，可以使用`let sum=x+y将 x+y `的结果保存在变量 sum 中。

这种情况下 (( )) 显然更加灵活，可以使用`$((x+y))`来获取 x+y 的结果。请看下面的例子：
```shell
[c.biancheng.net]$ a=10 b=20
[c.biancheng.net]$ echo $((a+b))
30
[c.biancheng.net]$ echo let a+b  #错误，echo会把 let a+b作为一个字符串输出
let a+b
```
$ Shell let 命令实例演示
【实例1】个变量i加8
```shell
[root@zntsa ~]# i=2
[root@zntsa ~]# let i+=8
[root@zntsa ~]# echo $i
10
```
let i+=8 等同于 ((i+=8))，但后者效率更高。

【实例2】let 后面可以跟多个表达式。
```shell
[c.biancheng.net]$ a=10 b=35
[c.biancheng.net]$ let a+=6 c=a+b  #多个表达式以空格为分隔
[c.biancheng.net]$ echo $a $c
16 51
```