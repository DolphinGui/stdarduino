#!/usr/bin/sh

set -ex

cd binutils
git format-patch 6091cec --stdout > ../binutils.patch
cd ..

cd gcc
git format-patch b71f1de --stdout > ../gcc.patch
cd ..