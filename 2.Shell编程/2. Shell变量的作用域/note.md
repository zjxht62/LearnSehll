Shell变量的作用域可以分为三种：
+ 有的变量只能在函数内部使用，叫做局部变量（local variable）
+ 有的变量可以在当前Shell进程中使用，叫做全局变量（global variable）
+ 而有的变量还可以在子进程中使用，叫做环境变量（environment variable）

# Shell局部变量
Shell和Java等编程语言不同：在Shell函数中定义的变量，默认也是全局变量，它和在函数外部定义变量拥有一样的效果。
```shell
#!/bin/bash

# 定义函数
function func() {
    a=99
}
# 调用函数
func
# 输出函数内部变量
echo $a
```
运行结果：99，a虽然是在函数内部定义的，但是在函数的外部也能获取的值，证明其作用域是全局的，而不仅限于函数内部。

通过添加`local`命令，可以使得变量变为局部变量。
```shell
#!/bin/bash
# 定义函数
function func() {
    local a=99
}
# 调用函数
func
# 输出函数内部的变量
echo $a
```
输出结果为空，表明变量是一个局部变量。

Shell变量的特性和JavaScript中的变量特性类似。在JavaScript函数中定义的变量，默认也是全局变量，只有加上`var`关键字，它才会变成局部变量。
