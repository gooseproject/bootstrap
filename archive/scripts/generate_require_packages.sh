#!/bin/bash

# run from rpms directory after running generate_requires.sh

rm requires/*.packages
for i in *.src.rpm
do
  for j in $( cat requires/${i}.{requires,specreqs} | tr -d ' ' | sort | uniq )
  do
      ls ${j}*.src.rpm >> requires/${i}.packages 2> /dev/null 
  done
done
