# Shell 数组拼接，Shell数组合并
所谓Shell数组合并（拼接），就是将两个数组连接成一个数组

思路是：先利用`@`或者`*`，将数组扩展成列表，然后再合并到一起。具体格式如下：
```shell
array_new=(${array1[@]}  ${array2[@]})
array_new=(${array1[*]}  ${array2[*]})
```
两种方式是等价的，选择其一即可。其中，array1 和 array2 是需要拼接的数组，array_new 是拼接后形成的新数组。

完整演示代码：
```shell
#!/bin/bash

array1=(23 56)
array2=(99 "http://c.biancheng.net/shell/")
array_new=(${array1[@]} ${array2[*]})

echo ${array_new[@]}  #也可以写作 ${array_new[*]}
```
运行结果：
```shell
23 56 99 http://c.biancheng.net/shell/
```