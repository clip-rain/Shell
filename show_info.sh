#!/bin/bash

while IFS='|'  read -r name age gender
do
    echo "$name is $age old. His(Her) gender is $gender"
done < ./test.tmp
