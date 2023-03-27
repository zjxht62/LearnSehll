# Shell declare和typeset命令：设置变量属性
declare 和 typeset 都是 Shell 内建命令，它们的用法相同，都用来设置变量的属性。不过 typeset 已经被弃用了，建议使用 declare 代替。

declare命令的用法如下所示
```shell
declare [+/-] [aAfFgilprtux] [变量名=变量值]
```
其中，`-`表示设置属性，`+`表示取消属性，`aAfFgilprtux`都是具体的选项，它们的含义如下表所示：

|选项|含义|
|---|---|
|-f [name]	|列出之前由用户在脚本中定义的函数名称和函数体。|
|-F [name]	|仅列出自定义函数名称。|
|-g name	|在 Shell 函数内部创建全局变量。|
|-p [name]	|显示指定变量的属性和值。|
|-a name	|声明变量为普通数组。|
|-A name	|声明变量为关联数组（支持索引下标为字符串）。|
|-i name 	|将变量定义为整数型。|
|-r name[=value] 	|将变量定义为只读（不可修改和删除），等价于 readonly name。|
|-x name[=value]	|将变量设置为环境变量，等价于 export name[=value]。|

【示例1】将变量声明为整数并进行计算
```shell
#!/bin/bash

declare -i m n ret # 将多个变量声明为整数
m=10
n=30
ret=$m+$n
echo $ret
```
运行结果：
40

【实例2】将变量定义为只读变量。
```shell
[root@zntsa 21.Shell declare和typeset命令]# declare -r n=10
[root@zntsa 21.Shell declare和typeset命令]# n=20
-bash: n: readonly variable
[root@zntsa 21.Shell declare和typeset命令]# echo $n
10
```
【实例3】显示变量的属性和值。
```shell
[root@zntsa 21.Shell declare和typeset命令]# declare -p n
declare -r n="10"
```