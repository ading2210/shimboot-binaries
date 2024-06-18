#!/bin/bash

base_dir="$(realpath "$(dirname $0)")"
if [ "$(basename "$base_dir")" = "packages" ]; then
  base_dir="$(dirname "$base_dir")"
fi

build_dir="$base_dir/build"
chroot_dir="$base_dir/alpine"
out_dir="$base_dir/out"
misc_dir="$base_dir/misc"

set -e
set -x