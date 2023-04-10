# Shell 函数参数
和 C++、C#、Python 等大部分编程语言不同，Shell 中的函数在定义时不能指明参数，但是在调用时却可以传递参数。

函数参数是 Shell 位置参数的一种，在函数内部可以使用`$n`来接收，例如，$1 表示第一个参数，$2 表示第二个参数，依次类推。

除了`$n`，还有另外三个比较重要的变量：
+ `$#`可以获取传递的参数的个数；
+ `$@`或者`$*`可以一次性获取所有的参数

`$n`、`$#`、`$@`、`$*` 都属于特殊变量

【实例1】使用 $n 来接收函数参数。
```shell
#!/bin/bash

# 定义函数
function show() {
    echo "Tutorial: $1"
    echo "URL: $2"
    echo "Author: "$3
    echo "Total $# parameters"
}

# 调用函数
show C# http://c.biancheng.net/csharp/ Tom
```
运行结果：
```shell
$ sh code1.sh
Tutorial: C#
URL: http://c.biancheng.net/csharp/
Author: Tom
Total 3 parameters
```
注意，第 7 行代码的写法有点不同，这里使用了 Shell 字符串拼接技巧。

【实例2】使用$@来遍历函数参数
```shell
#!/bin/bash

function getsum() {
    local sum=0

    for n in $@
    do
      ((sum+=n))
    done

    echo $sum
    return 0
}

# 调用函数并传递参数，最后将结果赋值给一个变量
total=$(getsum 10 20 55 15)
echo $total


# 也可以将变量省略
echo $(getsum 10 20 55 15)
```
运行结果
```shell
100
100
```
