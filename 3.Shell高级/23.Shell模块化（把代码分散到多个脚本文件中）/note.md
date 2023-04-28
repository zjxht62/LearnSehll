# Shell模块化（把代码分散到多个脚本文件中）
所谓模块化，就是把代码分散到多个文件或者文件夹中。对于中大型项目，模块化是必须的，否则会在一个文件中堆积成千上万行代码，这简直是一种灾难。

基本上所有的编程语言都支持模块化，以达到代码复用的效果，比如，Java和Python中有import，C/C++中有#include。在Shell中，我们可以使用source命令来实现类似的效果。

source命令的用法为：
```shell
source filename
```
也可以简写为
```shell
. filename
```
两种写法的效果相同。对于第二种写法，注意点号`.`和文件名中间有一个空格。

source是Shell内置命令的一种，它会读取filename文件中的代码，并依次执行所有语句。你也可以理解为，source命令会强制执行脚本文件中的全部命令，而忽略脚本文件的权限。

**实例**
创建两个脚本文件 func.sh 和 main.sh：func.sh 中包含了若干函数，main.sh 是主文件，main.sh 中会包含 func.sh。

func.sh文件内容：
```shell
#计算所有参数的和
function sum(){
    local total=0
    for n in $@
    do
         ((total+=n))
    done
    echo $total
    return 0
}
```

main.sh 文件内容：
```shell
#!/bin/bash
source func.sh
echo $(sum 10 20 55 15)
```
运行 main.sh，输出结果为：
```
100
```
source 后边可以使用相对路径，也可以使用绝对路径，这里我们使用的是相对路径。

# 避免重复引入
