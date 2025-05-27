#!/bin/bash

. ./common.sh

if [ "$EUID" -ne 0 ]; then 
  echo "this needs to be run as root"
  exit 1
fi

alpine_script_url="https://raw.githubusercontent.com/alpinelinux/alpine-chroot-install/master/alpine-chroot-install"
alpine_deps="
  bash wget unzip flex bison upx python3 make gcc libc-dev \
  fuse3-static fuse3-dev meson linux-headers readline-dev \
  zlib-dev libffi-dev zlib-static readline-static ncurses-static \
  autoconf gettext gettext-dev libtool automake argp-standalone \
  util-linux-dev util-linux-static lvm2-dev lvm2-static \
  popt-static popt-dev json-c-dev libssh-dev gettext-static \
  openssl-libs-static libtasn1-dev libtpms-dev libtpms \
  json-glib-dev gmp-dev glib-static pcre2 device-mapper-static
"
if [ ! -d "$chroot_dir" ]; then
  mkdir -p "$chroot_dir"
  wget "$alpine_script_url" -O "$chroot_dir/alpine-chroot-install"
  chmod +x "$chroot_dir/alpine-chroot-install"
  "$chroot_dir/alpine-chroot-install" -d "$chroot_dir" -a $(uname -m)
  "$chroot_dir/enter-chroot" apk add --no-cache --update --repository=https://dl-cdn.alpinelinux.org/alpine/v3.16/main/ libexecinfo-dev
fi
"$chroot_dir/enter-chroot" apk add $alpine_deps

mkdir -p "$build_dir"
mkdir -p "$out_dir"
if [ ! -f "$out_dir/lklfuse" ]; then
  "$chroot_dir/enter-chroot" ./packages/lklfuse.sh
fi
if [ ! -f "$out_dir/fusermount3" ]; then
  "$chroot_dir/enter-chroot" ./packages/fusermount3.sh
fi
if [ ! -f "$out_dir/python3" ]; then
  "$chroot_dir/enter-chroot" ./packages/python3.sh
fi
if [ ! -f "$out_dir/cryptsetup" ]; then
  "$chroot_dir/enter-chroot" ./packages/cryptsetup.sh
fi
if [ ! -f "$out_dir/swtpm" ]; then
  "$chroot_dir/enter-chroot" ./packages/swtpm.sh
fi
if [ ! -f "$out_dir/unionfs" ]; then
  "$chroot_dir/enter-chroot" ./packages/unionfs.sh
fi