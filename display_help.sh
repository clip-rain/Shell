#!/bin/bash
:<<F 
1. Display list of all users currently logged in
2. Get help on a particular command
Press <Ctrl+D> to exit
F

echo "1. Display list of all users currently logged in"
echo "2. Get help on a particular command"
echo "Press <Ctrl+D> to exit"
read -p "please input : " input
# =~ 用于判断等式左边是否匹配右边的正则表达式
if ! [[ $input =~ ^[0-9]+$ ]];
then
  echo input is error
fi

case $input in 
1) who;;
2) read -p "please input your command:" c
   man $c
   ;;
*) echo error input
;;
esac