# Shell until循环用法详解
until循环和while循环恰好相反，当判断条件不成立的时候才进入循环，一旦判断条件成立，就终止循环。

until 使用的场景很少，一般使用while即可。

Shell until循环的用法如下：
```shell
until condition
do
  statements    
done
```
`condition`表示条件，`statements`表示要执行的语句（可以多条），`do`和`done`都是Shell中的关键字

until循环的执行流程为：
+ 先对 condition 进行判断，如果该条件不成立，就进入循环，执行 until 循环体中的语句（do 和 done 之间的语句），这样就完成了一次循环。
+ 每一次执行到 done 的时候都会重新判断 condition 是否成立，如果不成立，就进入下一次循环，继续执行循环体中的语句，如果成立，就结束整个 until 循环，执行 done 后面的其它 Shell 代码。
+ 如果一开始 condition 就成立，那么程序就不会进入循环体，do 和 done 之间的语句就没有执行的机会。

注意，在 until 循环体中必须有相应的语句使得 condition 越来越趋近于“成立”，只有这样才能最终退出循环，否则 until 就成了死循环，会一直执行下去，永无休止。

使用until 循环，计算1加到100的值
```shell
#!/bin/bash

sum=0
i=1
until (( i>100 )); do
  ((sum+=i))
  ((i++))
done
echo "The sum is: $sum"
```
运行结果：
```shell
$ sh code1.sh
The sum is: 5050
```

在 while 循环中，判断条件为`((i<=100))`，这里将判断条件改为`((i>100))`，两者恰好相反，请读者注意区分。
