#!/bin/sh
# check the gender of the input. boy for b or B, girl for g or G, show unknow for others.

while true
do
  echo please input
  read i_gender
  echo input is $i_gender
  # caution, you must put empty space around the `=`
  if [ $i_gender = "g" -o $i_gender = "G" ];
  then
    echo He is a boy.
  elif [ $i_gender = "B" -o $i_gender = "b" ];
  then
    echo She is a girl.
  else
    echo "I don't know"
    break
  fi
done

:<<EOF
EOF
while true
do
  read n
  case $n in
    b) echo boy;;
    B) echo "boy"
    ;;
    g) echo "girl"
    ;;
    G) echo "girl"
    ;;
    *) echo "unknown"
    break
    ;;
  esac

done

while true
do
read -p "第一个数：" a
read -p "第二个数：" b
read -p "操作符：" c

case $c in
    +) let result=$a+$b
    ;;
    -) let result=$a-$b
    ;;
    # we should use `\` to escape '*’. otherwise '*' would act as wildcard.
    \*) let result=$a*$b
    ;;
    /) let result=$a/$b
    ;;
esac
echo $result
if [ $result == 0 ];
then
    break
fi
done  


