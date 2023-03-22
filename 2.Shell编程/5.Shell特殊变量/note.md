# Shell特殊变量：Shell $#、$*、$@、$?、$$
| 变量 | 含义 |
|-------|--------|
| $0 | 当前脚本的文件名。 |
| $n（n≥1） | 传递给脚本或函数的参数。n 是一个数字，表示第几个参数。例如，第一个参数是 $1，第二个参数是 $2。 |
| $# | 传递给脚本或函数的参数个数。 |
| $* | 传递给脚本或函数的所有参数。 |
| $@	 | 传递给脚本或函数的所有参数。当被双引号" "包含时，$@ 与 $* 稍有不同，我们将在《Shell $*和$@的区别》一节中详细讲解。 |
| $?	 | 上个命令的退出状态，或函数的返回值，我们将在《Shell $?》一节中详细讲解。 |
| $$	 | 当前 Shell 进程 ID。对于 Shell 脚本，就是这些脚本所在的进程 ID。 |

# 1)给脚本文件传递参数
```shell
#!/bin/bash
echo "Process ID: $$"
echo "File Name: $0"
echo "First Parameter : $1"
echo "Second Parameter : $2"
echo "All parameters 1: $@"
echo "All parameters 2: $*"
echo "Total: $#"
```
```shell
[root@zntsa 5.Shell特殊变量]# sh code1.sh 111 222
Process ID: 5433
File Name: code1.sh
First Parameter : 111
Second Parameter : 222
All parameters 1: 111 222
All parameters 2: 111 222
```
# 2)给函数传递参数
```shell
#!/bin/bash
#定义函数
function func(){
    echo "Language: $1"
    echo "URL: $2"
    echo "First Parameter : $1"
    echo "Second Parameter : $2"
    echo "All parameters 1: $@"
    echo "All parameters 2: $*"
    echo "Total: $#"
}
#调用函数
func Java http://c.biancheng.net/java/
```
```shell
[root@zntsa 5.Shell特殊变量]# sh code2.sh
Language: Java
URL: http://c.biancheng.net/java/
First Parameter : Java
Second Parameter : http://c.biancheng.net/java/
All parameters 1: Java http://c.biancheng.net/java/
All parameters 2: Java http://c.biancheng.net/java/
Total: 2
```