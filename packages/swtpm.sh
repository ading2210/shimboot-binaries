#https://gitlab.com/cryptsetup/cryptsetup
#./configure --enable-static-cryptsetup --enable-static --disable-shared --disable-asciidoc --prefix=$(realpath prefix)

#!/bin/bash

. ./common.sh
cd "$build_dir"

if [ ! -d "swtpm" ]; then
  wget "https://github.com/stefanberger/swtpm/archive/refs/heads/master.zip" -O swtpm-master.zip
  unzip -q swtpm-master.zip
  rm swtpm-master.zip
  mv swtpm-master swtpm
fi

if [ ! -d "json-glib" ]; then
  wget "https://gitlab.gnome.org/GNOME/json-glib/-/archive/main/json-glib-main.zip" -O json-glib-main.zip
  unzip -q json-glib-main.zip
  rm json-glib-main.zip
  mv json-glib-main json-glib
fi

if [ ! -d "pcre2" ]; then
  wget "https://github.com/PCRE2Project/pcre2/archive/refs/heads/master.zip" -O pcre2-master.zip
  unzip -q pcre2-master.zip
  rm pcre2-master.zip
  mv pcre2-master pcre2
fi

#alpine doesn't have a static lib for pcre2
cd "$build_dir/pcre2"
autoreconf -fi
./configure --disable-shared
make install-strip -j$(nproc --all)

#alpine doesn't have a static lib for json-glib
cd "$build_dir/json-glib"
meson setup _build . --reconfigure --default-library=static
meson compile -C _build
meson install -C _build

cd "$build_dir/swtpm"
mkdir -p prefix
prefix_dir="$(realpath prefix)"
export CFLAGS="-fno-stack-protector"
export LDFLAGS="--static"
export LIBS="-lcrypto -lssl -lffi -lpcre2-posix"

autoreconf -fi
./configure --prefix="$prefix_dir" --disable-shared --disable-tests --without-gnutls --without-seccomp --without-cuse
make clean
make install-strip -j$(nproc --all)

upx -q --best prefix/bin/swtpm
cp prefix/bin/swtpm "$out_dir"