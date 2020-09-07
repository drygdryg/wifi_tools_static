#!/bin/sh
set -e

wpas_tgz="wpa_supplicant-2.9.tar.gz"
wpas_url="https://www.w1.fi/releases/$wpas_tgz"
wpas_dir="${wpas_tgz%.tar.gz}"

prefix="`pwd`/prefix"
binaries="`pwd`/binaries"

# fetch source code archive
[ -f "$wpas_tgz" ] || wget $wpas_url

# unpack source files
[ -d "$wpas_dir"   ] || tar xf "${wpas_tgz}"

# set wpa_supplicant build configuration
cp wpa_supplicant_build_config "$wpas_dir/wpa_supplicant/.config"

# build wpa_supplicant
if ! [ -f "${wpas_dir}/wpa_supplicant/wpa_supplicant" ] ; then
    cd "$wpas_dir/wpa_supplicant/"
    (
    export PKG_CONFIG_PATH="${prefix}/lib/pkgconfig"
    make -j`nproc --all` \
        LIBS+="-L${prefix}/lib -lnl-genl-3 -lnl-3" \
        LDFLAGS+="-static"
    # binaries output directory
    [ -d "$binaries" ] || mkdir $binaries

    cp wpa_supplicant "$binaries/"
    cp wpa_cli "$binaries/"
    cp wpa_passphrase "$binaries/"
    strip -s "$binaries/wpa_supplicant"
    strip -s "$binaries/wpa_cli"
    strip -s "$binaries/wpa_passphrase"
    )
fi

echo "wpa_supplicant has been compiled. Executables placed in $binaries"
