# Shell read:读取从键盘输入的数据
read是Shell的内置命令，从标准输入的读取数据并赋值给变量。如果没有进行重定向，默认就是从键盘读取用户的输入数据；如果进行了重定向，那么可以从文件中读取数据。

read命令的用法为：
```shell
read [-options] [variables]
```
`options`表示选项，如下表所示；`variable`三表示用来存储数据的变量，可以有一个或多个。
`options`和`variables`都是可选的，如果没有提供变量名，那么读取的数据将存储在环境变量REPLY中。

Shell read命令支持的选项

|选项|说明|
|---|---|
|-a array	|把读取的数据赋值给数组 array，从下标 0 开始。|
|-d delimiter|用字符串 delimiter 指定读取结束的位置，而不是一个换行符（读取到的数据不包括 delimiter）。|
|-e	|在获取用户输入的时候，对功能键进行编码转换，不会直接显式功能键对应的字符。|
|-n num	|读取 num 个字符，而不是整行字符。|
|-p prompt	|显示提示信息，提示内容为 prompt。|
|-r	|原样读取（Raw mode），不把反斜杠字符解释为转义字符。|
|-s	|静默模式（Silent mode），不会在屏幕上显示输入的字符。当输入密码和其它确认信息的时候，这是很有必要的。|
|-t seconds	|设置超时时间，单位为秒。如果用户没有在指定时间内输入完成，那么 read 将会返回一个非 0 的退出状态，表示读取失败。|
|-u fd	|使用文件描述符 fd 作为输入源，而不是标准输入，类似于重定向。|

【实例1】使用read命令给多个变量赋值
```shell
#!/bin/bash

read -p "Enter some information >" name url age
echo "网站名字：${name}"
echo "网址：${url}"
echo "年龄：${age}"
```
运行结果
```shell
Enter some information >zjx http:sss 1324 zzz
网站名字：zjx
网址：http:sss
年龄：1324 zzz
```
注意，必须在一行内输入所有的值，不能换行，否则只能给第一个变量赋值，后续变量都会赋值失败。

本例还使用了-p选项，该选项会用一段文本来提示用户输入。

【示例2】只读取一个字符。
```shell
#!/bin/bash

read -n 1 -p "Enter a char >" char
printf "\n" # 换行
echo $char
```
运行结果：
```shell
Enter a char >c
c
```
`-n 1`表示只读取一个字符。运行脚本后，只要用户输入一个字符，立即读取结束，不用等待用户按下回车键。

`printf "\n"`语句用来达到换行的效果，否则 echo 的输出结果会和用户输入的内容位于同一行，不容易区分。

【实例3】在指定时间内输入密码。

