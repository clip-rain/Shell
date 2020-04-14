#!/bin/bash
# 统计某个目录及其所有目录下的文件的大小，并打印出来。

# { 和函数名字间要又空格。
function scanDir {
    # $1 表示第一个参数。用sed将ls展示的文件内容分成多行，每行表示一个文件。（理论上，这里也可以使用ls -al 然后用awk取第一列）
    for file in `ls $1 | sed -e 's/ /\n/g'`;
    do
        entire_path="$1/$file"
        #如果为文件夹，则迭代。
        if [ -d $entire_path ]
        then
            scanDir $entire_path
        else
            echo $entire_path
        fi
    done
}

path=".."

files=`scanDir $path`
for file in $files;
do
    wc -c $file
done
