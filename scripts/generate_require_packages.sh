#!/bin/bash

# run from rpms directory after running generate_requires.sh

for i in requires/*.requires
do
  for j in $(cat $i) 
  do
    ls ${j}*.src.rpm > ${i}.packages 2> /dev/null
  done
done
