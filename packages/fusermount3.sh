#!/bin/bash

. ./common.sh
cd "$build_dir"

if [ ! -d "libfuse" ]; then
  wget "https://github.com/libfuse/libfuse/archive/refs/heads/master.zip" -O libfuse-master.zip
  unzip -q libfuse-master.zip
  rm libfuse-master.zip
  mv libfuse-master libfuse
fi

cd libfuse
mkdir -p build
cd build
meson setup ..
meson configure --default-library static \
  -D buildtype=release \
  -D prefer_static=true \
  -D c_link_args="-static -s -flto" \
  -D cpp_link_args="-static -s -flto" 
ninja

chmod 04711 util/fusermount3
cp util/fusermount3 "$out_dir"