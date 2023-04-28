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