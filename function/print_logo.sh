#!/usr/bin/env bash
# print logo
logo='


 _______ _   _ ___
|_  / _ \ | | / __|
 / /  __/ |_| \__ \
/___\___|\____|___/


'

IFS_OLD=$IFS
IFS=$'\n'

echo -e "\033[046;037;01m$(printf "%30s" " ")\033[0m"
echo -e "\033[046;037;01m$(printf "%30s" " ")\033[0m"
for str in $logo
do
  p=$(printf "%20s" "$str")
  split=$(printf "%-5s" " ")
  echo -e "\033[046;037;01m$split$p$split\033[0m"
done
echo -e "\033[046;037;01m$(printf "%30s" " ")\033[0m"
echo -e "\033[046;037;01m$(printf "%30s" " ")\033[0m"
IFS=$IFS_OLD