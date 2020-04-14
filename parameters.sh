#!/bin/bash
# author:leiyu
# 2020/02/03

echo "传递参数的例子！"
# $n来引用参数和文件名
echo "执行的文件名：$0"
echo "第一个参数： $1"
echo "第二个参数； $2"
echo "第三个参数： $3"

# $#表示参数个数
echo "参数个数：$#"
# $* 和 $@ 都可以表示所有参数，二者不同是$@表示一个数组，$*将所有参数视为一个完整的参数
echo " \$@ 演示"
for i in "$@"; do
  echo $i
done

echo "\$* 演示"
for i in "$*"; do
  echo $i
done



