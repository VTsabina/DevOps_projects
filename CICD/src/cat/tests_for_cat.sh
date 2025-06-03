#!/bin/bash

SUCCESS=0
FAIL=0
COUNTER=0
DIFF=""

s21_command=(
    "./s21_cat"
    )
sys_command=(
    "cat"
    )

tests=(
"OPTIONS test_files/test_1.txt"
)
flags=(
    "b"
    "e"
    "n"
    "s"
    "t"
    "v"
)
manual=(
"-b test_files/test_1.txt"
"-b test_files/test_1.txt nofile.txt"
"-e test_files/test_1.txt"
"-e test_files/test_1.txt nofile.txt"
"-n test_files/test_2.txt"
"-n test_files/test_2.txt nofile.txt"
"-s test_files/test_3.txt"
"-s test_files/test_3.txt nofile.txt"
"-t test_files/test_3.txt"
"-t test_files/test_3.txt nofile.txt"
"-n test_files/test_4.txt"
"-v test_files/test_5.txt"
"-- test_files/test_5.txt"
"no_file.txt"
"-n -b test_files/test_1.txt"
"-s -n -e test_files/test_4.txt"
"test_files/test_1.txt -n"
"-b -e -n -s -t -v test_files/test_3.txt"
"-benstv test_files/test_3.txt"
)

run_test() {
    param=$(echo "$@" | sed "s/OPTIONS/$var/")
    "${s21_command[@]}" $param > "${s21_command[@]}".log
    "${sys_command[@]}" $param > "${sys_command[@]}".log
    DIFF="$(diff -s "${s21_command[@]}".log "${sys_command[@]}".log)"
    let "COUNTER++"
    if [ "$DIFF" == "Files "${s21_command[@]}".log and "${sys_command[@]}".log are identical" ]
    then
        let "SUCCESS++"
        echo "\033[31m$FAIL\033[0m/\033[32m$SUCCESS\033[0m/$COUNTER \033[32mSuccess\033[0m  $param"
    else
        let "FAIL++"
        echo "\033[31m$FAIL\033[0m/\033[32m$SUCCESS\033[0m/$COUNTER \033[31mFail\033[0m  $param"
    fi
    rm -f "${s21_command[@]}".log "${sys_command[@]}".log
}

echo "#######################"
echo "MANUAL TESTS"
echo "#######################"
printf "\n"

for i in "${manual[@]}"
do
    var="-"
    run_test "$i"
done
printf "\n"
echo "#######################"
echo "AUTOTESTS"
echo "#######################"
printf "\n"
echo "+++++++++++++++++++++++"
echo "1 PARAMETER"
echo "+++++++++++++++++++++++"
printf "\n"

for var1 in "${flags[@]}"
do
    for i in "${tests[@]}"
    do
        var="-$var1"
        run_test "$i"
    done
done
printf "\n"
echo "+++++++++++++++++++++++"
echo "2 PARAMETERS"
echo "+++++++++++++++++++++++"
printf "\n"

for var1 in "${flags[@]}"
do
    for var2 in "${flags[@]}"
    do
        if [ $var1 != $var2 ]
        then
            for i in "${tests[@]}"
            do
                var="-$var1 -$var2"
                run_test "$i"
            done
        fi
    done
done
printf "\n"
echo "+++++++++++++++++++++++"
echo "3 PARAMETERS"
echo "+++++++++++++++++++++++"
printf "\n"
for var1 in "${flags[@]}"
do
    for var2 in "${flags[@]}"
    do
        for var3 in "${flags[@]}"
        do
            if [ $var1 != $var2 ] && [ $var2 != $var3 ] && [ $var1 != $var3 ]
            then
                for i in "${tests[@]}"
                do
                    var="-$var1 -$var2 -$var3"
                    run_test "$i"
                done
            fi
        done
    done
done
printf "\n"
echo "+++++++++++++++++++++++"
echo "4 PARAMETERS"
echo "+++++++++++++++++++++++"
printf "\n"
for var1 in "${flags[@]}"
do
    for var2 in "${flags[@]}"
    do
        for var3 in "${flags[@]}"
        do
            for var4 in "${flags[@]}"
            do
                if [ $var1 != $var2 ] && [ $var2 != $var3 ] \
                && [ $var1 != $var3 ] && [ $var1 != $var4 ] \
                && [ $var2 != $var4 ] && [ $var3 != $var4 ]
                then
                    for i in "${tests[@]}"
                    do
                        var="-$var1 -$var2 -$var3 -$var4"
                        run_test "$i"
                    done
                fi
            done
        done
    done
done
# 2 параметра
for var1 in "${flags[@]}"
do
    for var2 in "${flags[@]}"
    do
        if [ $var1 != $var2 ]
        then
            for i in "${tests[@]}"
            do
                var="-$var1$var2"
                run_test "$i"
            done
        fi
    done
done

# 3 параметра
for var1 in "${flags[@]}"
do
    for var2 in "${flags[@]}"
    do
        for var3 in "${flags[@]}"
        do
            if [ $var1 != $var2 ] && [ $var2 != $var3 ] && [ $var1 != $var3 ]
            then
                for i in "${tests[@]}"
                do
                    var="-$var1$var2$var3"
                    run_test "$i"
                done
            fi
        done
    done
done
printf "\n"
echo "\033[31mFAILED: $FAIL\033[0m"
echo "\033[32mSUCCESS: $SUCCESS\033[0m"
echo "ALL: $COUNTER"
printf "\n"

##############################