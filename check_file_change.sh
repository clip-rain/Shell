#!/bin/bash
# 定时检查文件是否又更改

scanDir(){
  # one parameter
  for i in ` ls $1 | sed -e 's/ /\n/g' `;
  do
    # if this is a dir
    if [ -d $1/$i ];
    then
      #continue
      checkDir "$1/$i"
    else
      # 函数内部的变量是全局的，在外部也能访问到。这方面没有深究，貌似不同的shell对变量的作用域设置都不一样。
      # 函数内部echo并不会把内容打印到标准输出流，而是输出到了函数的返回流中，类似return。
      echo "$1/$i"
    fi
  done
}

if [[ $2 =~ ^[0-9]+$ ]]
then
  sleep_time=$2
  echo "set period as $sleep_time seconds"
else
  sleep_time=5
  echo "default period is 5 seconds"
fi

for i in `scanDir $1`;
do
  index=$[ index+1 ]
  files[$index]=$i
  echo ${files[$index]}
done

echo =================
echo ${files[@]}
echo ================

# incase some the two files are exist before our monintor begain. delete them first.
rm -f /tmp/stat.temp
rm -f /tmp/nstat.temp

while true
do
  if [ -e /tmp/stat.temp ]
  # if stat.temp exist, indicate that we collect all the change infos of all files already and store them in stat.temp
  then
    for i in ${files[@]};
    do
      echo -ne $i >> /tmp/nstat.temp
      stat -x $i | grep Change >> /tmp/nstat.temp
    done
    diff /tmp/stat.temp /tmp/nstat.temp > /tmp/diff.temp
    if [ $? -eq 0 ]
    then
      # if result of diff to diff.temp is 0, it shows that the two file are the same, so there is no change.
      echo "no file change"
    else
      # there are some files changed in this branch
      echo "below file(s) are changed:"
      # diff 命令会用'<'打头左边文件的内容，'>'打头右边文件的内容。这里把右边的内容打印出来。
      cat /tmp/diff.temp | grep ">"
      patch /tmp/stat.temp /tmp/diff.temp
      rm /tmp/diff.temp
    fi
    rm /tmp/nstat.temp
    sleep $sleep_time
  else
    # first time, we should collect all the infos of all files and store them.
    for i in ${files[@]};
    do
      echo collect $i
      # -n 代表不换行，-e 表示激活转义字符。目前测试发现-n和-e在bash可用，在sh不能用。
      echo -ne $i >> /tmp/stat.temp
      # -x 在mac os下必须加，不然不会得到change的信息。
      stat -x $i | grep Change >> /tmp/stat.temp
    done
    echo infos are collected
    sleep 2
  fi
done








