在Bash shell中，每个变量的值都是字符串，无论给变量赋值时有没有使用引号，值都会以字符串的形式存储。

# 定义变量
Shell支持以下三种定义变量的方式：
```shell
variable=value
variable='value'  # 注意，赋值号=的周围不能有空格，这可能和你熟悉的大部分编程语言都不一样。
variable="value"
```
如果 value 不包含任何空白符（例如空格、Tab 缩进等），那么可以不使用引号；如果 value 包含了空白符，那么就必须使用引号包围起来。使用单引号和使用双引号也是有区别的，稍后我们会详细说明。

Shell 变量的命名规范和大部分编程语言都一样：
+ 变量名由数字、字母、下划线组成；
+ 必须以字母或者下划线开头；
+ 不能使用 Shell 里的关键字（通过 help 命令可以查看保留关键字）。

# 使用变量
```shell
author="zjx"
echo $author
echo ${author} # 加花括号是为了帮助解释器识别变量的边界
```
推荐给所有变量加上花括号{ }，这是个良好的编程习惯。

# 修改变量的值
```shell
url="http://c.biancheng.net"
echo ${url}
url="http://c.biancheng.net/shell/"
echo ${url}
```
第二次对变量赋值时不能在变量名前加$，只有在使用变量时才能加$。

# 单引号和双引号的区别
```shell
#!/bin/bash
url="http://c.biancheng.net"
website1='C语言中文网：${url}'
website2="C语言中文网：${url}"
echo $website1
echo $website2
```
```shell
结果
C语言中文网：${url}
C语言中文网：http://c.biancheng.net
```
+ 以单引号' '包围变量的值时，单引号里面是什么就输出什么，即使内容中有变量和命令（命令需要反引起来）也会把它们原样输出。这种方式比较适合定义显示纯字符串的情况，即不希望解析变量、命令等的场景。
+ 以双引号" "包围变量的值时，输出时会先解析里面的变量和命令，而不是把双引号中的变量名和命令原样输出。这种方式比较适合字符串中附带有变量和命令并且想将其解析后再输出的变量定义。

我的建议：如果变量的内容是数字，那么可以不加引号；如果真的需要原样输出就加单引号；其他没有特别要求的字符串等最好都加上双引号，定义变量时加双引号是最常见的使用场景。

# 将命令结果赋值给变量
Shell 也支持将命令的执行结果赋值给变量，常见的有以下两种方式：
```shell
variable=`command`
variable=$(command)
```
第一种方式把命令用反引号` `（位于 Esc 键的下方）包围起来，反引号和单引号非常相似，容易产生混淆，所以不推荐使用这种方式；第二种方式把命令用$()包围起来，区分更加明显，所以推荐使用这种方式。

# 只读变量
使用 readonly 命令可以将变量定义为只读变量，只读变量的值不能被改变。

下面的例子尝试更改只读变量，结果报错：
```shell
#!/bin/bash
myUrl="http://c.biancheng.net/shell/"
readonly myUrl
myUrl="http://c.biancheng.net/shell/"
```
```shell
bash: myUrl: This variable is read only.
```

# 删除变量
使用unset命令可以删除变量
```shell
unset variable_name
```
变量被删除后不能再次使用；unset 命令不能删除只读变量。

```shell
#!/bin/sh
myUrl="http://c.biancheng.net/shell/"
unset myUrl
echo $myUrl
```
上面的脚本没有任何输出。
