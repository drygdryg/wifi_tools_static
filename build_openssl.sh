#!/bin/sh
set -e

openssl_tgz="openssl-1.1.1i.tar.gz"
openssl_url="https://www.openssl.org/source/$openssl_tgz"
openssl_dir="${openssl_tgz%.tar.gz}"

prefix="`pwd`/prefix"

# fetch source code archive
[ -f "$openssl_tgz" ] || wget $openssl_url

# output directory
[ -d "$prefix" ]    || mkdir prefix

# unpack source files
[ -d "$openssl_dir"   ] || tar xf "${openssl_tgz}"

# build OpenSSL
if ! [ -f "${prefix}/lib/libcrypto.a" ] ; then
    cd $openssl_dir
    (
    ./config --prefix=$prefix no-shared no-stdio no-tests
    make -j`nproc --all`
    make install
    )
fi

echo "OpenSSL library has been compiled"
