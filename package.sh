#!/bin/bash

./buildall.sh

rm -rf PKG

mkdir PKG

cp *.TCF PKG/
cp FDOOM*.EXE PKG/
cp WAD/*.WAD PKG/
cp README.txt PKG/
cp synthgs.sbk PKG/
cp BENCH.BAT PKG/
cp -r INTER PKG/INTER
cp -r BENCH PKG/BENCH
cp EXE/* PKG

versionstring=$(grep "#define FDOOMVERSION" FASTDOOM/version.h)
version=$(echo "$versionstring" | awk -F'"' '{print $2}')

rm FastDoom_$version.zip

cd PKG
7zz a -r -mx9 ../FastDoom_$version.zip .
cd ..

rm -rf PKG
