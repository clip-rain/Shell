#!/bin/bash

A=1
# be careful for the defination of array. The separator is a whitespace.
my_array=($A B C D "E")
echo $my_array
for i in ${my_array[*]}; do 
# or use $my_array[*] or $my_array[@]
 echo $i
done

index=0
length=${#my_array[@]}
echo "lenght is $length"
echo "length of ${#my_array}  ${#my_array[*]}"
while [ $index -lt $length ]
do
 echo ${my_array[$index]}
 let index++ # or you can use let "index++" or index=$[$index+1]
done

