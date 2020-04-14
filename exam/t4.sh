#/bin/bash
# 简单的计算器，可以计算加减乘除

read -p "input your first number:" a
read -p "input your second number:" b
read -p "input your operation ( + - * /):" c

case $c in
+) echo $[$a+$b]
;;
-) echo `expr $a - $b`
;;
\*) echo `expr $a \* $b`
;;
/) echo $[$a/$b]
;;
*) echo error operation
;;
esac