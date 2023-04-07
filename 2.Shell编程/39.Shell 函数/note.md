# Shell函数详解（函数定义、函数调用）
Shell函数的本质是一段可以重复执行的脚本代码，这段代码被提前编写好，放在指定的位置，使用时直接调用即可。

Shell 中的函数和C++、Java、Python、C# 等其它编程语言中的函数类似，只是在语法细节有所差别。

Shell函数定义的语法格式如下：
```shell
function name() {
    statements
    [retuen value]
}
```
对各个部分的说明：
+ `function`是 Shell 中的关键字，专门用来定义函数；
+ `name`是函数名；
+ `statements`是函数要执行的代码，也就是一组语句；
+ `return value`表示函数的返回值，其中 return 是 Shell 关键字，专门用在函数中返回一个值；这一部分可以写也可以不写。

由`{}`包围的部分称为函数体，调用一个函数，实际上就是执行函数体中的代码。

# 函数定义的简化写法
如果嫌麻烦，可以不写function关键字：
```shell
name() {
  statements
  [return value]
}
```
如果写了function关键字，也可以省略函数名后面的小括号：
```shell
function name {
  statements
  [retuen value]
    
}
```
我建议使用标准的写法，这样能够做到“见名知意”，一看就懂。

# 函数调用
调用Shell函数时可以给它传递参数，也可以不传递。如果不传递参数，直接给出函数名即可：
```shell
name
```
如果要传递参数，那么多个参数之间以空格分隔：
```shell
name param1 param2 param3
```
不管是哪种形式，函数名称后面都不需要带括号

和其它编程语言不同的是，**Shell 函数在定义时不能指明参数，但是在调用时却可以传递参数，并且给它传递什么参数它就接收什么参数。**

Shell 中的函数需要先定义，再调用

# 实例演示
1)定义一个函数，输出Shell教程的地址：
```shell
#!/bin/bash

# 定义函数
function url() {
    echo "http://c.biancheng.net/shell/"
}

# 函数调用
url
```
运行结果：
```shell
$ sh code1.sh
http://c.biancheng.net/shell/
```
2) 定义一个函数，计算所有参数的和：
```shell
#!/bin/bash

function getsum() {
    local sum=0

    for n in $@
    do
      ((sum+=n))
    done

    return $sum
}

getsum 10 20 55 15
echo $?
```
运行结果：
```shell
100
```

`$@`表示函数的所有参数，`$?`表示函数的退出状态（返回值）。关于如何获取函数的参数，我们将在《Shell函数参数》一节中详细讲解。

此处我们借助 return 关键字将所有数字的和返回，并使用`$?`得到这个值，这种处理方案在其它编程语言中没有任何问题，但是在 Shell 中是非常错误的，
Shell 函数的返回值和其它编程语言大有不同，我们将在《Shell函数返回值》中展开讨论。