.PHONY: all clean libnl iw wpa_supplicant

all: libnl iw wpa_supplicant

libnl:
	./build_libnl.sh

openssl:
	./build_openssl.sh

iw:
	libnl
	./build_iw.sh

wpa_supplicant:
	libnl
	./build_wpas.sh

clean:
	rm -rf *.tar.gz *.tar.xz prefix/ binaries/ libnl-3.5.0/ openssl-1.1.1g/ iw-5.8/ wpa_supplicant-2.9/
