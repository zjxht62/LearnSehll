# Shell expr命令：对整数进行运算
expr 是 evaluate expressions 的缩写，译为“表达式求值”。Shell expr 是一个功能强大，并且比较复杂的命令，它除了可以实现整数计算，还可以结合一些选项对字符串进行处理，例如计算字符串长度、字符串比较、字符串匹配、字符串提取等。

本节只讲解 expr 在整数计算方面的应用，并不涉及字符串处理，有兴趣的读者请自行研究。

Shell expr 对于整数计算的用法为：
```shell
expr 表达式
```
expr 对`表达式`的格式有几点特殊的要求：
+ 出现在`表达式`中的运算符、数字、变量和小括号的左右两边至少要有一个空格，否则会报错。
+ 有些特殊符号必须用反斜杠`\`进行转义（屏蔽其特殊含义），比如乘号`*`和小括号`()`，如果不用`\`转义，那么 Shell 会把它们误解为正则表达式中的符号（`*`对应通配符，`()`对应分组）。
+ 使用变量时要加`$`前缀。

【实例1】expr 整数计算简单举例：
```shell
[c.biancheng.net]$ expr 2 +3  #错误：加号和 3 之前没有空格
expr: 语法错误
[c.biancheng.net]$ expr 2 + 3  #这样才是正确的
5
[c.biancheng.net]$ expr 4 * 5  #错误：乘号没有转义
expr: 语法错误
[c.biancheng.net]$ expr 4 \* 5  #使用 \ 转义后才是正确的
20
[c.biancheng.net]$ expr ( 2 + 3 ) \* 4  #小括号也需要转义
bash: 未预期的符号 `2' 附近有语法错误
[c.biancheng.net]$ expr \( 2 + 3 \) \* 4  #使用 \ 转义后才是正确的
20
[c.biancheng.net]$ n=3
[c.biancheng.net]$ expr n + 2  #使用变量时要加 $
expr: 非整数参数
[c.biancheng.net]$ expr $n + 2  #加上 $ 才是正确的
5
[c.biancheng.net]$ m=7
[c.biancheng.net]$ expr $m \* \( $n + 5 \)
56
```
以上是直接使用 expr 命令，计算结果会直接输出，如果你希望将计算结果赋值给变量，那么需要将整个表达式用反引号``（位于 Tab 键的上方）包围起来，请看下面的例子。

【实例2】将 expr 的计算结果赋值给变量：
```shell
[c.biancheng.net]$ m=5
[c.biancheng.net]$ n=`expr $m + 10`
[c.biancheng.net]$ echo $n
15
```

