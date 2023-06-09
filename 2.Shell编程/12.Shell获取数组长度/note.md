# Shell获取数组长度
数组长度，就是数组中包含元素的个数

利用`@`或`*`，可以将数组扩展成列表，然后使用#来获取数组元素的个数，格式如下：
```shell
${#array_name[@]}
${#array_name[*]}
```
其中 array_name 表示数组名。两种形式是等价的，选择其一即可。

如果某个元素是字符串，还可以通过指定下标的方式获得该元素的长度，如下所示：
```shell
${#arr[2]}
```
获取 arr 数组的第 2 个元素（假设它是字符串）的长度。

**回忆字符串长度的获取**
回想一下 Shell 是如何获取字符串长度的呢？其实和获取数组长度如出一辙，它的格式如下：
```shell
${#string_name}
```
string_name 是字符串名。

# 示例演示：
```shell
#!/bin/bash

nums=(29 100 13)
echo ${#nums[*]}

# 向数组中添加元素
nums[10]="http://c.biancheng.net/shell/"
echo ${#nums[@]}
echo ${#nums[10]}

#删除数组元素
unset nums[1]
echo ${#nums[*]}
```
运行结果
```shell
3
4
29
3

```