# Linux使用什么命令查看进程

使用ps命令，可以查看当前的进程。默认情况下，ps命令只会输出当前用户并且是当前终端（比如，当前Shell）下调用的进程的信息。其输出将类似如下所示：
```shell
[root@zntsa ~]# ps
  PID TTY          TIME CMD
22372 pts/2    00:00:00 bash
24211 pts/2    00:00:00 ps
```
我们从上面的输出中可以看到，默认情况下，ps 命令会显示进程 ID(PID)、与进程关联的终端（TTY）、格式为“[dd-]hh:mm:ss”的进程累积 CPU 时间（TIME），以及可执行文件的名称（CMD）。并且，输出内容默认是不排序的。

使用标准语法显示系统中的每个进程：
```shell
[root@zntsa ~]# ps -ef | head -2
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 Jan30 ?        00:16:55 /usr/lib/systemd/systemd --switched-root --system --deserialize 21
```
使用 BSD 语法显示系统中的每个进程：
```shell
[root@zntsa ~]# ps -aux | head -2
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  51608  3888 ?        Ss   Jan30  16:55 /usr/lib/systemd/systemd --switched-root --system --deserialize 21
```
使用 BSD 样式选项会增加进程状态（STAT）等信息作为默认显示，你也可以使用 PS_FORMAT 环境变量重写默认的输出格式。

查看系统中 httpd 进程的信息：
```shell
ps aux | grep httpd
```
使用 pstree 命令，可以显示进程树的信息：
```shell
[root@zntsa ~]# pstree
systemd─┬─abrt-watch-log
        ├─abrtd
        ├─agetty
        ├─atd
        ├─crond
        ├─cupsd
        ├─dbus-daemon
        ├─gpio
        ├─gssproxy───5*[{gssproxy}]
        ├─irqbalance
        ├─lsmd
        ├─lvmetad
        ├─mysqld_safe───mysqld───20*[{mysqld}]
        ├─polkitd───5*[{polkitd}]
        ├─rsyslogd───2*[{rsyslogd}]
        ├─smartd
        ├─sshd─┬─sshd───bash
        │      ├─sshd───sshd
        │      └─sshd─┬─2*[bash]
        │             ├─bash───pstree
        │             └─sshd
        ├─systemd-journal
        ├─systemd-logind
        ├─systemd-udevd
        └─tuned───4*[{tuned}]
```
pstree命令以树形结构的形式显示系统中所有当前运行的进程的信息。此树形结构以指定的PID为根，若没有指定PID，则以init进程为根。下面，我们看一个显示指定PID的进程树的例子。
```shell
[c.biancheng.net]$ pstree 4578
httpd-11*[httpd]
```
上述输出内容的含义是，PID 是 4578 的 httpd 进程下有 11 个 httpd 子进程。在显示时，pstree 命令会将一样的分支合并到一个方括号中，并在方括号前显示重复的次数。

如果 pstree 命令指定的参数是用户名，那么就会显示以此用户的进程为根的所有进程树的信息。其显示内容将类似如下所示：
```shell
[root@zntsa ~]# pstree root
systemd─┬─abrt-watch-log
        ├─abrtd
        ├─agetty
        ├─atd
        ├─crond
        ├─cupsd
        ├─dbus-daemon
        ├─gpio
        ├─gssproxy───5*[{gssproxy}]
        ├─irqbalance
        ├─lsmd
        ├─lvmetad
        ├─mysqld_safe───mysqld───20*[{mysqld}]
        ├─polkitd───5*[{polkitd}]
        ├─rsyslogd───2*[{rsyslogd}]
        ├─smartd
        ├─sshd─┬─sshd───bash
        │      ├─sshd───sshd
        │      └─sshd─┬─2*[bash]
        │             ├─bash───pstree
        │             └─sshd
        ├─systemd-journal
        ├─systemd-logind
        ├─systemd-udevd
        └─tuned───4*[{tuned}]
```
使用 pgrep 命令，可以基于名称或其他属性查找进程。

pgrep 命令会检查当前运行的进程，并列出与选择标准相匹配的进程的 ID。例如，查看 root 用户的 sshd 进程的 PID：
```shell
[root@zntsa ~]# pgrep -u root sshd
1439
21592
21594
21636
21670
21672
```
列出所有者是 root 和 daemon 的进程的 PID：
```shell
pgrep -u root,daemon
```
