#!/bin/bash

. ./common.sh
cd "$build_dir"

if [ ! -d "unionfs-fuse" ]; then
  wget "https://github.com/rpodgorny/unionfs-fuse/archive/refs/heads/master.zip" -O unionfs-fuse-master.zip
  unzip -q unionfs-fuse-master.zip
  rm unionfs-fuse-master.zip
  mv unionfs-fuse-master unionfs-fuse
fi

cd unionfs-fuse
LDFLAGS="-static" CFLAGS="-O3" make -j$(nproc --all)
upx -q --best src/unionfs
cp src/unionfs "$out_dir"