#!/bin/bash
# a bash can't return string directly.

:<< F
three way that we can give feedback to outside of the function.
1.Echo a string
2.Return an exit status, which is a number, not a string
3.Share a variable
F

function r (){
    printf %s%s $$ "r function\n"
    return 3
}

function s (){
    printf %s%s $$ "s functions\n" > /dev/null
    echo "9"
}


function test(){
    store_file="/tmp/address_book.tmp"
    result=1
    if ! [ -e $store_file ];
    then
        result=2
    else
        # -F: 不能写成 -F ":"
        declare $(awk -v name=$1 -F: '{if($1==name)print "result=0";else print "exit"}' $store_file)
        #eval $(awk -v name=$1 -F: '{if($1==name)print "result=0";}' $store_file)

    fi
    return $result
}
read -p "name: " name
test $name
echo $?

:<<E
echo $$
r
rr=$? 
s
ss=$(s)

echo $rr
echo "lei"
echo $ss
E
