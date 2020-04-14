#!/bin/bash
# print fabonacci array

read -p "please input the length of fabonacci array:" l
if [ $l -eq 0 -o $l -eq 1 ];
then
 echo $[$l-1]
fi
pre1=0
pre2=1
echo $pre1
echo $pre2
for i in `seq 3 $l`;
do
  n=$[$pre1+$pre2]
  echo $n
  pre1=$pre2
  pre2=$n
done
