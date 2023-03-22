# Shell关联数组（下标是字符串的数组）
关联数组使用字符串作为下标，而不是整数，可以做到见名知意

关联数组也称为“键值对（key-value）”数组，键（key）也即字符串形式的数组下标，值（value）也即元素值。

例如，我们可以创建一个叫做 color 的关联数组，并用颜色名字作为下标。
```shell
declare -A color
color["red"]="#ff0000"
color["green"]="#00ff00"
color["blue"]="#0000ff"
```
也可以在定义的同时赋值：
```shell
declare -A color=(["red"]="#ff0000", ["green"]="#00ff00", ["blue"]="#0000ff")
```
不同于普通数组，关联数组必须使用带有-A选项的 declare 命令创建。关于 declare 命令的详细用法请访问：Shell declare和typeset命令：设置变量属性
# 访问关联数组元素
访问关联数组元素的方式几乎与普通数组相同，具体形式为：
```shell
array_name["index"]
```
例如：
```shell
color["white"]="#ffffff"
color["black"]="#000000"
```
加上`${}`即可获取数组元素的值：
```shell
${array_name["index"]}
```
例如：
```shell
echo ${color["white"]}
white=${color["black"]}
```
## 获取所有元素的下标和值
使用下面的形式可以获得关联数组的所有元素值：
```shell
${array_name[@]}
${array_name[*]}
```
使用下面的形式可以获取关联数组的所有下标值：
```shell
${!array_name[@]}
${!array_name[*]}
```
# 获取关联数组长度
使用下面的形式可以获得关联数组的长度：
```shell
${#array_name[*]}
${#array_name[@]}
```

示例代码：
```shell
#!/bin/bash

declare -A color
color["red"]="#ff0000"
color["green"]="#00ff00"
color["blue"]="#0000ff"
color["white"]="#ffffff"
color["blask"]="#000000"

# 获取所有元素值
for value in ${color[*]}
do
  echo $value
done
echo "******************"

# 获取所有元素下标（key，键）
for key in ${!color[*]}
do
  echo $key
done
echo "******************"

#列出所有键值对
for key in ${!color[@]}
do
    echo "${key} -> ${color[$key]}"
done
```
运行结果：
```shell
[root@zntsa 15.Shell关联数组]# sh code1.sh 
#ff0000
#000000
#0000ff
#ffffff
#00ff00
******************
red
blask
blue
white
green
******************
red -> #ff0000
blask -> #000000
blue -> #0000ff
white -> #ffffff
green -> #00ff00

```
