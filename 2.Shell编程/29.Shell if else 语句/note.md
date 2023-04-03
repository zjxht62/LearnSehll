# Shell if else语句（详解版）
Shell也支持选择结构，而且有两种形式，分别是if else语句和case in语句。

# if语句
最简单的用法是只使用if语句，格式为：
```shell
if condition
then
  statement(s)
fi 
```
`condition`是判断条件，如果condition成立（返回为“真”），那么then后面的语句将会执行；如果 condition 不成立（返回“假”），那么不会执行任何语句。
> 从本质上讲，if 检测的是命令的退出状态，我们将在下节《Shell退出状态》中深入讲解。

注意，最后必须以`fi`来闭合，fi 就是 if 倒过来拼写。也正是有了 fi 来结尾，所以即使有多条语句也不需要用`{ }`包围起来。

如果你喜欢，也可以将 then 和 if 写在一行：
```shell
if condition; then
  statement(s)
fi 
```
请注意 condition 后边的分号`;`，当 if 和 then 位于同一行的时候，这个分号是必须的，否则会有语法错误。

**实例1**

下面的例子使用if语句来比较两个数字的大小:
```shell
#!/bin/bash

read a
read b

if (($a==$b)); then
    echo "a和b相等"
fi
```
```shell
运行结果：
84↙
84↙
a和b相等
```
`(())`是一种数学计算命令，它除了可以进行最基本的加减乘除，还可以进行大于，小于等关系运算，以及与或非逻辑运算。当a和b相等时，`(($a==$b))`判断条件成立，
进入if，执行then后面的echo语句。

**实例2**

在判断条件中也可以使用逻辑运算符，例如：
```shell
#!/bin/bash

read age
read iq

if (($age>18 && $iq < 60)); then
  echo "你都成年了，智商怎么还不及格！"
  echo "来C语言中文网（http://c.biancheng.net/）学习编程吧，能迅速提高你的智商。"

fi
```
```shell
运行结果：
20↙
56↙
你都成年了，智商怎么还不及格！
来C语言中文网（http://c.biancheng.net/）学习编程吧，能迅速提高你的智商。
```

`&&`就是逻辑“与”运算符，只有当`&&`两侧的判断条件都为“真”时，整个判断条件才为“真”。

熟悉其他编程语言的读者请注意，即使 then 后边有多条语句，也不需要用`{ }`包围起来，因为有 fi 收尾呢。

# if else 语句
如果有两个分支，就可以使用if else语句，格式为：
```shell
if condition
then
  statement1
else 
  statement2
fi
```
如果 condition 成立，那么 then 后边的 statement1 语句将会被执行；否则，执行 else 后边的 statement2 语句。

举例：
```shell
#!/bin/bash
read a
read b
if (( $a == $b ))
then
    echo "a和b相等"
else
    echo "a和b不相等，输入错误"
fi
```
```shell
运行结果：
10↙
20↙
a 和 b 不相等，输入错误
```
从运行结果可以看出，a 和 b 不相等，判断条件不成立，所以执行了 else 后边的语句。

# if elif else 语句
Shell 支持任意数目的分支，当分支比较多时，可以使用 if elif else 结构，它的格式为：
```shell
if  condition1
then
   statement1
elif condition2
then
    statement2
elif condition3
then
    statement3
……
else
   statementn
fi
```
注意，if 和 elif 后边都得跟着 then。

整条语句的执行逻辑为：
+ 如果 condition1 成立，那么就执行 if 后边的 statement1；如果 condition1 不成立，那么继续执行 elif，判断 condition2。
+ 如果 condition2 成立，那么就执行 statement2；如果 condition2 不成立，那么继续执行后边的 elif，判断 condition3。
+ 如果 condition3 成立，那么就执行 statement3；如果 condition3 不成立，那么继续执行后边的 elif。
+ 如果所有的 if 和 elif 判断都不成立，就进入最后的 else，执行 statementn。

举个例子，输入年龄，输出对应的人生阶段：
```shell
#!/bin/bash
read age
if (( $age <= 2 )); then
    echo "婴儿"
elif (( $age >= 3 && $age <= 8 )); then
    echo "幼儿"
elif (( $age >= 9 && $age <= 17 )); then
    echo "少年"
elif (( $age >= 18 && $age <=25 )); then
    echo "成年"
elif (( $age >= 26 && $age <= 40 )); then
    echo "青年"
elif (( $age >= 41 && $age <= 60 )); then
    echo "中年"
else
    echo "老年"
fi
```
```shell
运行结果1：
19
成年

运行结果2：
100
老年
```
再举一个例子，输入一个整数，输出该整数对应的星期几的英文表示：
```shell
#!/bin/bash
printf "Input integer number: "
read num
if ((num==1)); then
    echo "Monday"
elif ((num==2)); then
    echo "Tuesday"
elif ((num==3)); then
    echo "Wednesday"
elif ((num==4)); then
    echo "Thursday"
elif ((num==5)); then
    echo "Friday"
elif ((num==6)); then
    echo "Saturday"
elif ((num==7)); then
    echo "Sunday"
else
    echo "error"
fi
```
```shell
运行结果1：
Input integer number: 4
Thursday

运行结果2：
Input integer number: 9
error
```