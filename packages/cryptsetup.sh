#https://gitlab.com/cryptsetup/cryptsetup
#./configure --enable-static-cryptsetup --enable-static --disable-shared --disable-asciidoc --prefix=$(realpath prefix)

#!/bin/bash

. ./common.sh
cd "$build_dir"

if [ ! -d "cryptsetup" ]; then
  wget "https://gitlab.com/cryptsetup/cryptsetup/-/archive/main/cryptsetup-main.zip" -O cryptsetup-main.zip
  unzip -q cryptsetup-main.zip
  rm cryptsetup-main.zip
  mv cryptsetup-main cryptsetup
fi

cd cryptsetup
mkdir -p prefix
prefix_dir="$(realpath prefix)"
./autogen.sh
./configure --enable-static-cryptsetup --enable-static --disable-shared --disable-asciidoc --prefix="$prefix_dir"

make install-strip -j$(nproc --all)
upx -q --best prefix/sbin/cryptsetup.static
cp prefix/sbin/cryptsetup.static "$out_dir/cryptsetup"