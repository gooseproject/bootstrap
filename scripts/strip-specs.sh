#!/bin/bash

# run from src.rpm directory
mkdir specs

for i in *.src.rpm
do
  cd specs
  rpm2cpio ../${i} | cpio -iumd \*.spec
  cd ..
done
