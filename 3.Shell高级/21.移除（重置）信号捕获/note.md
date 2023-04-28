# Linux Shell移除（重置）信号捕获

如果我们在脚本中应用了捕获，我们通常会在脚本的结尾处，将接收到信号时的行为处理重置为默认模式。重置（移除）捕获的语法如下所示：
```shell
$ trap - signal [ signal ... ]
```
从上述语法中可以看出，使用破折号作为 trap 语句的命令参数，就可以移除信号的捕获。

下面，我们以脚本 trap_reset.sh为例，来学习如何在脚本中移除先前定义的捕获。其脚本的内容类似如下所示：
```shell
#!/bin/bash

#定义函数cleanup
function cleanup {
  # 如果变量msgfile所指定的文件存在
  if [[ -e $msgfile ]]; then
    # 将文件重命名（或移除）
    mv $msgfile $msgfile.dead
  fi

  exit
}

# 捕获INT和TERM信号
trap cleanup INT TERM

# 创建一个临时文件
msgfile=`mktemp /tmp/testtrap.$$.XXXXXX`

# 通过命令行向此临时文件写入内容
cat > $msgfile

#接下来，发送临时文件的内容到指定的邮件地址，你自己完善此部分代码
#send the contents of $msgfile to the specified mail address...

#删除临时文件
rm $msgfile

#移除信号INT和TERM的捕获
trap - INT TERM
```
上述脚本中，在用户已经完成了发送邮件的操作之后，临时文件会被删除。这时，因为已经不再需要清理操作，我们可以重置信号的捕获到默认状态，
所以我们在脚本的最后一行重置了 INT 和 TERM 信号的捕获。
