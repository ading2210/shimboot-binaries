# Shimboot Static Binaries

This repo contains scripts for building various utilities that are used within Shimboot. Everything is statically linked, and an Alpine Linux chroot is used to minimize the output size.

The following programs are compiled:
- [cryptsetup](https://gitlab.com/cryptsetup/cryptsetup)
- [lklfuse](https://github.com/libos-nuse/lkl-linux/blob/master/tools/lkl/lklfuse.c)
- [python-static](https://github.com/ading2210/python-static)
- [fusermount](https://github.com/libfuse/libfuse)
- [swtpm](https://github.com/stefanberger/swtpm)
- [unionfs-fuse](https://github.com/rpodgorny/unionfs-fuse)

## Example:
```
$ sudo ./build.sh
```

```
$ du out/*
2.0M    out/cryptsetup
92K     out/fusermount3
4.4M    out/lklfuse
5.4M    out/python3
1.8M    out/swtpm
516K    out/unionfs
```

```
$ ldd out/*
out/cryptsetup:
        not a dynamic executable
out/fusermount3:
        not a dynamic executable
out/lklfuse:
        not a dynamic executable
out/python3:
        not a dynamic executable
out/swtpm:
        not a dynamic executable
out/unionfs:
        not a dynamic executable
```

## Copyright:
The contents of this repository are licensed under the GNU GPL v3.

```
ading2210/shimboot-binaries: Scripts to build static binaries for Shimboot
Copyright (C) 2024 ading2210

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```