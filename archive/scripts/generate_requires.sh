#!/bin/bash

# pull all the RPMs into one directory then run this

mkdir requires
for i in *src.rpm
do 
  rpm -qRp ${i} > requires/${i}.requires
done
