#!/bin/bash
# 使用read命令来模仿cat读取整个文件的内容

# IFS internal field separator; 
# IFS typically includes the space, tab, and the newline.

# 要保证while循环中输出的内容包含空格，需要做下面两件事：
# 1. while 和 read之间加上IFS=。
# 2. while中echo变量的时候要用双引号扩起来。


#IFS='|'
echo "$*" # 一个用IFS拼起来的字符串
echo "$@" # 一个数组

# method 1: 
i=0
while IFS= read l
do
    i=`expr $i + 1`
    echo "$i $l"
done < $1


:<<E

# method 2: juset print $REPLY
while read
do
    echo "$REPLY"
done < $1
E