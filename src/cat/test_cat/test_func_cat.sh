#!/bin/bash

SUCCESS=0
FAIL=0
COUNTER=0
DIFF_RES=""

declare -a tests = 
"VAR test_case_cat.txt"

declare -a extra=(
"-b test_1_cat.txt"
"-e -v test_1_cat.txt"
"-E test_1_cat.txt"
"-n test_1_cat.txt"
"-s test_1_cat.txt"
"-t -v test_1_cat.txt"
"-e -v test_2_cat.txt"
"-T test_1_cat.txt"
"-E test_2_cat.txt"
"-n test_2_cat.txt"
"-t -v test_2_cat.txt"
"-T test_2_cat.txt"
"-b test_3_cat.txt"
"-e -v test_3_cat.txt"
"-E test_3_cat.txt"
"-n test_3_cat.txt"
"-t -v test_3_cat.txt"
"-T test_3_cat.txt"
"-s test_3_cat.txt"
"-b test_4_cat.txt"
"-e -v test_4_cat.txt"
"-E test_4_cat.txt"
"-n test_4_cat.txt"
"-s test_4_cat.txt"
"-t -v test_4_cat.txt"
"-T test_4_cat.txt"
"-T test_5_cat.txt"
"-t -v test_5_cat.txt"
"-v test_5_cat.txt"
"-e -v test.txt"
"-E test.txt"
"-T test.txt"
"-t -v test.txt"
"-n test.txt"
"-b no_file.txt"
"-e -v no_file.txt"
"-E no_file.txt"
"-n no_file.txt"
"-s no_file.txt"
"-t -v no_file.txt"
"-T no_file.txt"
"-b test_case_cat.txt"
"-e -v test_case_cat.txt"
"-E test_case_cat.txt"
"-n test_case_cat.txt"
"-s test_case_cat.txt"
"-t -v test_case_cat.txt"
"-v test_case_cat.txt"
"-n test_1_cat.txt test_2_cat.txt"
)

testing()
{
    t=$(echo $@ | sed "s/VAR/$var/")
    ./s21_cat $t > test_s21_cat.log
    cat $t > test_sys_cat.log
    DIFF_RES="$(diff -s test_s21_cat.log test_sys_cat.log)"
    (( COUNTER++ ))
    if [ "$DIFF_RES" == "Files test_s21_cat.log and test_sys_cat.log are identical" ]
    then
      (( SUCCESS++ ))
        echo "\033[31m$FAIL\033[0m/\033[32m$SUCCESS\033[0m/$COUNTER \033[32msuccess\033[0m cat $t"
    else
      (( FAIL++ ))
        echo "\033[31m$FAIL\033[0m/\033[32m$SUCCESS\033[0m/$COUNTER \033[31mfail\033[0m cat $t"
    fi
    rm test_s21_cat.log test_sys_cat.log
}

# специфические тесты
for i in "${extra[@]}"
do
    var="-"
    testing $i
done

# 1 параметр
for var1 in b e n s t v
do
    for i in "${tests[@]}"
    do
        var="-$var1"
        testing $i
    done
done

# # 2 параметра
# for var1 in b e n s t v
# do
#     for var2 in b e n s t v
#     do
#         if [ $var1 != $var2 ]
#         then
#             for i in "${tests[@]}"
#             do
#                 var="-$var1 -$var2"
#                 testing $i
#             done
#         fi
#     done
# done

# # 3 параметра
# for var1 in b e n s t v
# do
#     for var2 in b e n s t v
#     do
#         for var3 in b e n s t v
#         do
#             if [ $var1 != $var2 ] && [ $var2 != $var3 ] && [ $var1 != $var3 ]
#             then
#                 for i in "${tests[@]}"
#                 do
#                     var="-$var1 -$var2 -$var3"
#                     testing $i
#                 done
#             fi
#         done
#     done
# done

# # 4 параметра
# for var1 in b e n s t v
# do
#     for var2 in b e n s t v
#     do
#         for var3 in b e n s t v
#         do
#             for var4 in b e n s t v
#             do
#                 if [ $var1 != $var2 ] && [ $var2 != $var3 ] \
#                 && [ $var1 != $var3 ] && [ $var1 != $var4 ] \
#                 && [ $var2 != $var4 ] && [ $var3 != $var4 ]
#                 then
#                     for i in "${tests[@]}"
#                     do
#                         var="-$var1 -$var2 -$var3 -$var4"
#                         testing $i
#                     done
#                 fi
#             done
#         done
#     done
# done

echo "\033[31mFAIL: $FAIL\033[0m"
echo "\033[32mSUCCESS: $SUCCESS\033[0m"
echo "ALL: $COUNTER"
