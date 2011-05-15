#!/bin/bash

# run from src.rpm directory
mkdir specs

for i in *.src.rpm
do
  mkdir -p specs/${i}
  cd specs/${i}
  rpm2cpio ../../${i} | cpio --quiet -iumd \*.spec
  cd ../..
done
