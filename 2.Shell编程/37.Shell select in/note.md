# Shell select in 循环详解
select in 循环用来增强交互性，它可以显示出带编号的菜单，用户输入不同的编号就可以选择不同的菜单，并执行不同的功能。

select in 是Shell独有的一种循环、非常适合终端（Terminal）这样的交互场景，C语言、C++、Java、Python、C# 等其它编程语言中是没有的。

Shell select in循环的用法如下：
```shell
select variable in value_list
do
  statements
 done 
```
variable 表示变量，value_list 表示取值列表，in 是 Shell 中的关键字。你看，select in 和 for in 的语法是多么地相似。

我们先来看一个 select in 循环的例子：
```shell
#!/bin/bash

echo "What is your favourite OS?"
select name in "Linux" "Windows" "Mac OS" "UNIX" "Android"; do
  echo $name
done
echo "You have selected $name"
```
运行结果：
```shell
$ sh code1.sh
What is your favourite OS?
1) Linux
2) Windows
3) Mac OS
4) UNIX
5) Android
#? 1
Linux
#? 9

#? 4
UNIX
#? 2
Windows
#?
^D
You have selected Windows
```
`#?`用来提示用户输入菜单编号；`^D`表示按下` Ctrl+D `组合键，它的作用是结束 select in 循环。

取值列表 value_list 中的内容会以菜单的形式显示出来，用户输入菜单编号，就表示选中了某个值，这个值就会赋给变量 variable，然后再执行循环体中的 statements（do 和 done 之间的部分）。

每次循环时 select 都会要求用户输入菜单编号，并使用环境变量 PS3 的值作为提示符，PS3 的默认值为`#?`，修改 PS3 的值就可以修改提示符。

如果用户输入的菜单编号不在范围之内，例如上面我们输入的 9，那么就会给 variable 赋一个空值；如果用户输入一个空值（什么也不输入，直接回车），会重新显示一遍菜单。

**注意，select 是无限循环（死循环），输入空值，或者输入的值无效，都不会结束循环，只有遇到 break 语句，或者按下 Ctrl+D 组合键才能结束循环。**

完整实例

select in 通常和 case in 一起使用，在用户输入不同的编号时可以做出不同的反应。

修改上面的代码，加入 case in 语句：
```shell
#!/bin/bash
echo "What is your favourite OS?"
select name in "Linux" "Windows" "Mac OS" "UNIX" "Android"
do
    case $name in
        "Linux")
            echo "Linux是一个类UNIX操作系统，它开源免费，运行在各种服务器设备和嵌入式设备。"
            break
            ;;
        "Windows")
            echo "Windows是微软开发的个人电脑操作系统，它是闭源收费的。"
            break
            ;;
        "Mac OS")
            echo "Mac OS是苹果公司基于UNIX开发的一款图形界面操作系统，只能运行与苹果提供的硬件之上。"
            break
            ;;
        "UNIX")
            echo "UNIX是操作系统的开山鼻祖，现在已经逐渐退出历史舞台，只应用在特殊场合。"
            break
            ;;
        "Android")
            echo "Android是由Google开发的手机操作系统，目前已经占据了70%的市场份额。"
            break
            ;;
        *)
            echo "输入错误，请重新输入"
    esac
done
```
用户只有输入正确的编号才会结束循环，如果输入错误，会要求重新输入。

运行结果1，输入正确选项：
```shell
What is your favourite OS?
1) Linux
2) Windows
3) Mac OS
4) UNIX
5) Android
#? 2
Windows是微软开发的个人电脑操作系统，它是闭源收费的。
```
运行结果2，输入错误选项：
```shell
$ sh code2.sh
What is your favourite OS?
1) Linux
2) Windows
3) Mac OS
4) UNIX
5) Android
#? 7
输入错误，请重新输入
#? 4
UNIX是操作系统的开山鼻祖，现在已经逐渐退出历史舞台，只应用在特殊场合。
```
运行结果3，输入空值：
```shell
$ sh code2.sh
What is your favourite OS?
1) Linux
2) Windows
3) Mac OS
4) UNIX
5) Android
#?
1) Linux
2) Windows
3) Mac OS
4) UNIX
5) Android
#? 3
Mac OS是苹果公司基于UNIX开发的一款图形界面操作系统，只能运行与苹果提供的硬件之上。
```