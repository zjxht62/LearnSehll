# Shell数组：Shell数组定义以及获取数组元素
Shell也支持数组，数组（Array）是若干数据的集合，其中每个元素称之为元素（Element）

Shell 并且没有限制数组的大小，理论上可以存放无限量的数据。和 C++、Java、C# 等类似，Shell 数组元素的下标也是从 0 开始计数。

获取数组中的元素要使用下标`[ ]`，下标可以是一个整数，也可以是一个结果为整数的表达式；当然，下标必须大于等于 0。

但是，Bash Shell只支持一维数组，不支持多维数组。

# Shell数组的定义
在 Shell 中，用括号`( )`来表示数组，数组元素之间用空格来分隔。由此，定义数组的一般形式为：
```shell
array_name=(ele1 ele2 ele3 ... elen)
```
注意，赋值号=两边不能有空格，必须紧挨着数组名和数组元素。

下面是一个定义数组的实例：
```shell
nums=(29 100 13 8 91 44)
```
Shell 是弱类型的，它并不要求所有数组元素的类型必须相同，例如：
```shell
arr=(20 56 "http://c.biancheng.net/shell/")
```
第三个元素就是一个“异类”，前面两个元素都是整数，而第三个元素是字符串。

Shell 数组的长度不是固定的，定义之后还可以增加元素。例如，对于上面的 nums 数组，它的长度是 6，使用下面的代码会在最后增加一个元素，使其长度扩展到 7：
```shell
nums[6]=88
```
此外，你也无需逐个元素地给数组赋值，下面的代码就是只给特定元素赋值：
```shell
ages=([3]=24 [5]=19 [10]=12)
```
以上代码就只给第 3、5、10 个元素赋值，所以数组长度是 3。
# 获取数组元素
获取数组元素的值，一般使用下面的格式：
```shell
${array_name[index]}
```
其中，array_name 是数组名，index 是下标。例如：
```shell
n=${nums[2]}
```
表示获取 nums 数组的第二个元素，然后赋值给变量 n。再如：
```shell
echo ${nums[3]}
```
表示输出 nums 数组的第 3 个元素。

使用`@`或`*`可以获取数组中的所有元素，例如：
```shell
${nums[*]}
${nums[@]}
```
两者都可以得到 nums 数组的所有元素。


完整的示例：
```shell
#!/bin/bash

nums=(29 100 13 8 91 44)
echo ${nums[@]}  #输出所有数组元素
nums[10]=66  #给第10个元素赋值（此时会增加数组长度）
echo ${nums[*]}  #输出所有数组元素
echo ${nums[4]}  #输出第4个元素
echo ${nums[7]}  #输出第7个元素,结果为空
```
运行结果：
```shell
29 100 13 8 91 44
29 100 13 8 91 44 66
91

```