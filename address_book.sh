#!/bin/sh

store_file="/tmp/address_book.tmp"
back_store_file="/tmp/backup_address_book.tmp"

# check the person , return the line number it locate.
function check_person {
    result=0
    if ! [ -e $store_file ];
    then
        result=0
    else
        # -F: 不能写成 -F ":"  , 另外declare要求$()中必须有值，所以awk的else分支必须有输出结果。这里还必须将IFS设置一下。
        IFS=':' ; declare $(awk -v name=$1 -F';' 'BEGIN{printf "resultt=";} {if($1==name)print NR; else print "0"}' $store_file)
        # IFS=':' ; declare $(awk -v name="xyz" -F';' 'BEGIN{printf "resultt=";} {if($1==name)print NR; else print "0"}' /tmp/address_book.tmp )
        # or we can use eval. We can ignore the elase branch when we use eval.
        # eval $(awk -v name=$n -F':' '{if($1==name)print "result=0";}' $store_file)
        # echo $resultt
        # 如果用declare的话，结果是多行的形式
        while read l
        do
            if [ $l -gt 0 ];
            then
                result=$l
            fi
        done <<< $resultt
    fi
    return $result
}

function add_person {
    while true
    do
        read -p "name : " name
        check_person $name
        check_result=$?
        if [ $check_result -gt 0 ];
        then
            clear
            echo "duplicate name, please input again!" >&2
            continue
        fi
        read -p "phone number : " phone
        read -p "age : " age
        info="$name;$phone;$age"
        echo $info >> $store_file
        echo "save successfully!" >&2
        break
    done
}

function find_person {
    read -p "input the name you want to search:" name
    check_person $name
    check_result=$?
    if [ check_result = 0 ];
    then
        echo "not found!" >&2
    else
        # -F: 不能写成 -F ":"
        awk -v name=$name -F';' '{if($1==name)print $0;}' $store_file
        # or we can use eval. We can ignore the else branch when we use eval.
        # eval $(awk -v name=$n -F: '{if($1==name)print "result=0";}' $store_file)
    fi
}

function remove_person {
    read -p "please input the name of person who you want to remove: " name
    check_person $name
    check_result=$?
    #echo $check_result
    if [ $check_result -gt 0 ];
    then
        # 现获取该用户的行号
        c=$(awk -v name=$name -F';' '{if($1==name)print NR}' $store_file)
        
        # 根据行号删除。
        eval sed \'$c d\' $store_file > $back_store_file && mv $back_store_file $store_file
        # 或者直接写成, sed的输出是到标准输出流，所以重定向到&store_file中也行。
        # eval sed \'$c d\' $store_file > $store_file
        echo "remove sccussfully!" >&2
    else
        echo "the person is not exist!" >&2
    fi
}

function edit_person {
    # ask the user to input a valid name
    while true
    do
        read -p "input the name of person you want to edit:" name
        check_person $name
        check_result=$?
        if [ $check_result = 0 ];
        then
            #clear
            echo "not exist name, try again!" >&2
            continue
        else
            break
        fi
    done
    # 清空备份文件
    > $back_store_file

    while true
    do
        read -p "1. change phone number; 2, change age; do your choice:" choice
        if [[ ! $choice =~ ^[1,2]$ ]]
        then
            #clear
            echo "input your choice again:" >&2
            continue
        fi
        if [ $choice = 1 ]
        then
            read -p "input your new phone number: " number
        else
            read -p "input your new age: " ag
        fi
        break
    done

    # 也可以用这个循环来判断该用户是否存在
    while IFS=';' read n p a
    do
        if [ $n = $name ];
        then
            if [ $choice = 1 ]
            then
                p=$number
            else
                a=$ag
            fi
        fi
        info="$n;$p;$a"
        echo $info >> $back_store_file
    done < $store_file;
    mv $back_store_file $store_file
    echo "save successfully!" >&2 
    
}


while true
do
    echo "==========runbook=========="
    echo "1. add a new person"
    echo "2. remove a person"
    echo "3. edit a person"
    echo "4. find a person"
    echo "5. show all person"
    echo "6. exit the system"
    echo "==========runbook=========="
    read -p "please input your choice:" c

    if [[ ! $c =~ ^[1-6]$ ]]
    then
        clear
        echo "please input your choice again "
    fi

    case $c in
    1) add_person
    ;;
    2) remove_person
    ;;
    3) edit_person
    ;;
    4) find_person
    ;;
    5) cat -n $store_file
    ;;
    6) exit
    ;;
    esac
done