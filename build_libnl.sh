#!/bin/sh
set -e

libnl_tgz="libnl-3.5.0.tar.gz"
libnl_url="https://github.com/thom311/libnl/releases/download/libnl3_5_0/$libnl_tgz"
libnl_dir="${libnl_tgz%.tar.gz}"

prefix="`pwd`/prefix"

# fetch source code archive
[ -f "$libnl_tgz" ] || wget $libnl_url

# output directory
[ -d "$prefix" ]    || mkdir prefix

# unpack source files
[ -d "$libnl_dir" ] || tar xf "${libnl_tgz}"

# build libnl
if ! [ -f "${prefix}/lib/libnl-3.a" ] ; then
    (
	cd "$libnl_dir"
	./configure \
		--enable-static --disable-shared \
        --disable-cli --prefix=$prefix
	make -j`nproc --all`
	make install
    )
fi

echo "Netlink protocol library has been compiled"
