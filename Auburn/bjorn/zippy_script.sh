#!/bin/bash

set -e

i=0

while true
do
  if [ "$i" -eq 0 ]
  then
    # name of the first zip
    file_name='almost_there.zip'
  else
    file_name=$new_zip_filename
  fi
  rm found.hash
  new_zip_filename=$(7z l $file_name | grep -A2 Name | grep zip | awk '{print $6}')
  zip2john $file_name | cut -d: -f2 > automatedZip.hash
  # could have probably done fine with the rockyou wordlist
  hashcat -a 0 -m 13600 -O automatedZip.hash -o found.hash --outfile-format=2 ~/password_list/crackstation.txt
  password=$(cat found.hash)
  7z x -p$password $file_name
  i=$((i+1))
done
