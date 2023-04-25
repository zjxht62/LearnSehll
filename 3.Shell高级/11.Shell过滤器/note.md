# Shell过滤器

将几个命令可以通过管道符组合在一起成为一个管道。通常，通过这种方式使用的命令就被称为过滤器。**过滤器会获取输入，通过某种方式修改其内容，然后将其输出。
**

简单来说，过滤器可以概括为以下两点：

+ 如果一个Linux命令是从标准输入接收它的数据，并在标准输出上产生它的输出数据（结果），那么这个命令就被称为过滤器。
+ 过滤器通常与Linux管道一起使用

| 命令      | 说明                                        |
|---------|-------------------------------------------|
| awk     | 用于文本处理的解释性程序设计语言，通常被作为数据提取和报告的工具。         |
| cut     | 用于将每个输入文件（如果没有指定文件则为标准输入）的每行的指定部分输出到标准输出。 |
| grep    | 用于搜索一个或多个文件中匹配指定模式的行。                     |
| tar     | 用于归档文件的应用程序。                              |
| head    | 用于读取文件的开头部分（默认是 10 行）。如果没有指定文件，则从标准输入读取。  |
| paste   | 用于合并文件的行。                                 |
| sed     | 用于过滤和转换文本的流编辑器。                           |
| sort    | 用于对文本文件的行进行排序。                            |
| split   | 用于将文件分割成块。                                |
| strings | 用于打印文件中可打印的字符串。                           |
| tac     | 与 cat 命令的功能相反，用于倒序地显示文件或连接文件。             |
| tail    | 用于显示文件的结尾部分。                              |
| tee     | 用于从标准输入读取内容并写入到标准输出和文件。                   |
| tr	     | 用于转换或删除字符。                                |
| uniq    | 用于报告或忽略重复的行。                              |
| wc      | 用于打印文件中的总行数、单词数或字节数。                      |

接下来，我们通过几个实例来演示一下过滤器的使用。
# 在管道中使用 awk 命令

【实例1】查看系统中的所有的账号名称，并按名称的字母顺序排序
```shell
[root@zntsa ~]# awk -F ':' '{print $1}' /etc/passwd | sort
abrt
adm
bin
chrony
colord
daemon
dbus
ftp
games
```
在上例中，使用冒号`:`作为列分隔符，将文件/etc/passwd的内容分割成了多列，并打印了第一列的信息（即用户名），然后将输出通过管道发送到了sort命令。

【实例2】
列出当前账号最常使用的10个命令
```shell
[root@zntsa ~]# history | awk '{print $2}' | sort | uniq -c | sort -rn | head
    174 cd
    124 ll
    104 tcpreplay
     72 sh
     71 ls
     57 echo
     42 ps
     31 cat
     25 history
     23 crontab
```
在上例中，history命令将输出通过管道发送到awk命令，awk命令默认使用空格作为列分隔符，将history的输出分为了两列，并且把第二列的内容作为输出通过管道发送到了sort命令，
使用sort命令进行排序后，再将输出通过管道发送到了uniq命令，使用 uniq 命令 统计了历史命令重复出现的次数，再用 sort 命令将 uniq 命令的输出按照重复次数从高到低排序，
最后使用 head 命令默认列出前 10 个的信息。

【实例3】显示当前系统的总内存大小，单位为KB
```shell
[root@zntsa ~]# free | grep Mem | awk '{print $2}'
32692444
```
# 在管道中使用 cut 命令
cut 命令被用于文本处理。你可以使用这个命令来提取文件中指定列的内容。

【实例1】查看系统中登录Shell是"/bin/bash"的用户名和对应的用户主目录的信息：
```shell
[root@zntsa ~]# grep "bin/bash" /etc/passwd | cut -d: -f1,6
root:/root
mysql:/var/lib/mysql
znopers:/home/znopers
mysftp:/home/mysftp
```
如果你对 Linux 系统有所了解，你会知道，/ctc/passwd 文件被用来存放用户账号的信息，此文件中的每一行会记录一个账号的信息，每个字段之间用冒号分隔，
第一个字段即是账号的账户名，而第六个字段就是账号的主目录的路径。

【实例2】查看当前机器的CPU类型。
```shell
[root@zntsa ~]# cat /proc/cpuinfo |grep name | cut -d: -f2 | uniq
 Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
```
上例中，执行命令cat /proc/cpuinfo | grep name得到的内容如下所示：
```shell
[root@zntsa ~]# cat /proc/cpuinfo | grep name
model name      : Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
model name      : Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
model name      : Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
model name      : Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
```
然后，我们使用 cut 命令将上述输出内容以冒号作为分隔符，将内容分为了两列， 并显示第二列的内容，最后使用 uniq 命令去掉了重复的行。

【实例3】查看当前目录下的子目录数
```shell
[root@zntsa ~]# ls -l | cut -c 1| grep d|wc -l
14
```
上述管道命令主要做了如下操作：
+ 命令`ls -l`输出的内容中，每行的第一个字符表示文件的类型，如果第一个字符是d，就表示文件的类型是目录。
+ 命令`cut -c 1`是截取每行的第一个字符。
+ 命令`grep d`来获取文件类型是目录的行。
+ 命令`wc -l`用来获得 grep 命令输出结果的行数，即目录个数。

# 在管道中使用grep命令
grep 命令是在管道中比较常用的一个命令。

【实例1】查看系统日志文件中的错误信息
```shell
[c.biancheng.net]$ grep -i "error:" /var/log/messages | less
```

【实例2】查看系统中 HTTP 服务的进程信息。
```shell
[c.biancheng.net]$ ps auxwww | grep httpd
apache 18968 0.0 0.0 26472 10404 ?    S    Dec15    0:01 /usr/sbin/httpd
apache 18969 0.0 0.0 25528  8308 ?    S    Dec15    0:01 /usr/sbin/httpd
apache 18970 0.0 0.0 26596 10524 ?    S    Dec15    0:01 /usr/sbin/httpd
```

【实例3】查找我们的程序列表中所有命令名中包含关键字 zip 的命令。
```shell
[root@zntsa ~]# ls /bin /usr/bin | sort | uniq | grep zip
bunzip2
bzip2
bzip2recover
funzip
gpg-zip
gunzip
gzip
unzip
unzipsfx
zip
```
【实例4】查看系统安装的kernel版本及相关的kernel软件包
```shell
[root@zntsa ~]# rpm -qa | grep kernel
kernel-3.10.0-693.el7.x86_64
kernel-devel-3.10.0-693.el7.x86_64
kernel-headers-3.10.0-693.el7.x86_64
kernel-tools-3.10.0-693.el7.x86_64
kernel-tools-libs-3.10.0-693.el7.x86_64
abrt-addon-kerneloops-2.1.11-48.el7.centos.x86_64
```
【实例5】查找/etc目录下所有包含IP地址的文件
```shell
[c.biancheng.net]$ find /etc -type f -exec grep '[0-9][0-9]*[.][0-9][0-9]*[.][0-9][0-9]*[.][0-9][0-9]*' {} \;
```
# 在管道中使用 tar 命令
tar 命令是 Linux 系统中最常用的打包文件的程序。

【实例1】使用 tar 命令复制一个目录的整体结构。
```shell
tar cf - /home/mozhiyan | ( cd /backup/; tar xf - )
```
【实例2】 跨网络地复制一个目录的整体结构。
```shell
[c.biancheng.net]$ tar cf - /home/mozhiyan | ssh remote_host "( cd /backup/; tar xf - )"
```
【实例3】 跨网络地压缩复制一个目录的整体结构。
```shell
[c.biancheng.net]$ tar czf - /home/mozhiyan | ssh remote_host "( cd /backup/; tar xzf - )"
```
【实例4】 检査 tar 归档文件的大小，单位为字节。
```shell
[c.biancheng.net]$ cd /; tar cf - etc | wc -c
215040
```

【实例5】 检查 tar 归档文件压缩为 tar.gz 归裆文件后所占的大小。
```shell
[c.biancheng.net]$ tar czf - etc.tar | wc -c
58006
```

【实例6】 检查 tar 归档文件压缩为 tar.bz2 归裆文件后所占的大小。
```shell
[c.biancheng.net]$ tar cjf - etc.tar | wc -c
50708
```

# 在管道中使用 head 命令
有时，你不需要一个命令的全部输出，可能只需要命令的前几行输出。这时，就可以使用 head 命令，它只打印命令的前几行输出。默认的输出行数为 10 行。

【实例1】显示ls命令的前10行输出
```shell
[root@zntsa ~]# ls /usr/bin/ | head
[
a2p
abrt-action-analyze-backtrace
abrt-action-analyze-c
abrt-action-analyze-ccpp-local
abrt-action-analyze-core
abrt-action-analyze-oops
abrt-action-analyze-python
abrt-action-analyze-vmcore
abrt-action-analyze-vulnerability

```
【实例2】显示ls命令的前5行内容
```shell
[root@zntsa ~]# ls / | head -n 5
bin
boot
data
dev
etc
```

# 在管道中使用 uniq 命令
uniq 命令用于报告或删除重复的行。我们将使用一个测试文件进行管道中使用 uniq 命令的实例讲解，其内容如下所示：
```shell
[root@zntsa ~]# cat testfile 
This line occurs only once.
This line occurs twice.
This line occurs twice.
This line occurs three times.
This line occurs three times.
This line occurs three times.
```
【实例1】去掉输出中重复的行
```shell
[root@zntsa ~]# sort testfile | uniq
This line occurs only once.
This line occurs three times.
This line occurs twice.
```
【实例2】显示输出中各重复的行出现的次数，并按次数多少倒序显示。
```shell
[root@zntsa ~]# sort testfile | uniq -c | sort -nr
      3 This line occurs three times.
      2 This line occurs twice.
      1 This line occurs only once.
```
# 在管道中使用 wc 命令
wc 命令用于统计包含在文本流中的字符数、单同数和行数。
【实例1】统计当前登录到系统的用户数。
```shell
[root@zntsa ~]# who | wc -l
3
```
【实例2】统计当前的Linux系统中的进程数
```shell
[root@zntsa ~]# ps -ef | wc -l
152
```
