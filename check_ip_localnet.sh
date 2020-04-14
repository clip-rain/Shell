#!/bin/bash
# 问题：查找局域网内有多少个IP被使用

#使用ping命令
pin="ping -W 2 -c 2 "
p="192.168.1."

for i in {0..255};
do
 $pin$p$i >/dev/null
 if [ $? -eq 0 ];
 then
  echo $p$i is OK
 fi
 
done
