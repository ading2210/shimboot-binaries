#!/bin/bash

. ./common.sh

file_list="$(ls "$out_dir")"
files_str=""
for file_name in $file_list; do
  file_size="$(du -sh "$out_dir/$file_name" | cut -f -1)"
  files_str+="- $file_name ($file_size)"$'\n'
done

mkdir -p "$misc_dir"
tar -czf "$misc_dir/shimboot-binaries.tar.gz" -C "$out_dir" $(ls "$out_dir")

echo "This release contains:
$files_str" > "$misc_dir/release_notes.txt"