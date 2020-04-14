#!/bin/bash
# 计算n项和

if [ $# -eq 2 ];
then
  # 计算$1到$2间数字的和
  for i in `seq $1 $2`;
  do
    sum=$[$sum+$i]
  done
  echo "total is $sum"
elif [ $# -eq 1 ];
then 
  for i in `seq $1`;
  do
    sum=$[$sum+$i]
  done
  echo "total is $sum"
fi
    
