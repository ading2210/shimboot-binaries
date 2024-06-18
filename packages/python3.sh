#!/bin/bash

. ./common.sh
cd "$build_dir"

python_dir="$base_dir/packages/python-static"
cp -ar "$python_dir" "$build_dir"
cd python-static

if [ ! -f "/usr/lib/libtermcap.a" ]; then
  ln -s /usr/lib/libncurses.a /usr/lib/libtermcap.a
fi
./build_python.sh

upx -q --best ./main
cp ./main "$out_dir/python3"