#!/bin/bash

colors="./colors.txt"
countries="./countries.txt"
fruit="./fruit.txt"

while IFS= read -r colors_line
do
  while IFS= read -r countries_line
  do
    while IFS= read -r fruit_line
    do
      echo "$colors_line-$countries_line-$fruit_line" >> master_wordlist.txt
    done < $fruit
  done < $countries
done < $colors

echo "done"
