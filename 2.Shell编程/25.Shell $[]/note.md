# Shell $[]：对整数进行数学运算
和(())、let命令类似，$[]也只能进行整数运算

Shell $[]的用法如下：
```shell
$[表达式]
```
$[] 会对`表达式`进行计算，并取得计算结果。如果`表达式`中包含了变量，那么你可以加`$`，也可以不加。

Shell $[] 举例：
```shell
[c.biancheng.net]$ echo $[3*5]  #直接输出结算结果
15
[c.biancheng.net]$ echo $[(3+4)*5]  #使用()
35
[c.biancheng.net]$ n=6
[c.biancheng.net]$ m=$[n*2]  #将计算结果赋值给变量
[c.biancheng.net]$ echo $[m+n]
18
[c.biancheng.net]$ echo $[$m*$n]  #在变量前边加$也是可以的
72
[c.biancheng.net]$ echo $[4*(m+n)]
72
```
需要注意的是，不能单独使用 $[]，必须能够接收 $[] 的计算结果。例如，下面的用法是错误的：
```shell
[c.biancheng.net]$ $[3+4]
bash: 7: 未找到命令...
[c.biancheng.net]$ $[m+3]
bash: 15: 未找到命令...
```