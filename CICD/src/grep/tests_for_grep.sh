#!/bin/bash

SUCCESS=0
FAIL=0
COUNTER=0
DIFF=""

s21_command=(
    "./s21_grep"
    )
sys_command=(
    "grep"
    )

flags=(
    "v"
    "c"
    "n"
    "h"
)


tests=(
"s test_files/test_0.txt OPTIONS"
"for s21_grep.c Makefile OPTIONS"
"for s21_grep.c OPTIONS"
"-e for -e ^int s21_grep.c  Makefile OPTIONS"
"-e for -e ^int s21_grep.c OPTIONS"
"-e regex -e ^print s21_grep.c OPTIONS -f test_files/test_patterns.txt"
"-e while -e void s21_grep.c Makefile OPTIONS -f test_files/test_patterns.txt"
)

manual=(
"-n for test_files/test_1.txt test_files/test_2.txt"
"-n for test_files/test_1.txt"
"-ce ^int test_files/test_1.txt test_files/test_2.txt"
"-e ^int test_files/test_1.txt"
"-ie INT test_files/test_5.txt"
"-echar test_files/test_1.txt test_files/test_2.txt"
"-ne = -e out test_files/test_5.txt"
"-iv int test_files/test_5.txt"
"-in int test_files/test_5.txt"
"-v test_files/test_1.txt -e ank"
"-l for test_files/test_1.txt test_files/test_2.txt"
"-e = -e out test_files/test_5.txt"
"-e ing -e as -e the -e not -e is test_files/test_6.txt"
"-l for no_file.txt test_files/test_2.txt"
"-e int -si no_file.txt s21_grep.c no_file2.txt"
"-si s21_grep.c -f no_pattern.txt"
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
printf "\n"
echo "#######################"
echo "AUTOTESTS"
echo "#######################"
printf "\n"
echo "+++++++++++++++++++++++"
echo "DOUBLE PARAMETER"
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
                var="-$var1$var2"
                run_test "$i"
            done
        fi
    done
done

printf "\n"
echo "#######################"
echo "AUTOTESTS"
echo "#######################"
printf "\n"
echo "+++++++++++++++++++++++"
echo "TRIPLE PARAMETER"
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
