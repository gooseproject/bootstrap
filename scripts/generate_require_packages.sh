#!/bin/bash

# run from rpms directory after running generate_requires.sh

rm requires/*.packages
for i in requires/*.requires
do
  for j in $(cat $i)
  do
    echo $i, $j 
    ls ${j}*.src.rpm >> requires/${i}.packages 2> /dev/null 
  done 
done
