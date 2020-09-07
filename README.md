# Statically linked Wi-Fi tools for Linux/Android
This repository contains scripts for building statically linked **iw** and **wpa_supplicant** tools for Linux, which probably work on any Linux/Android distribution/version.
### Tested build environments:
* Alpine Linux edge armhf (running on Android under Linux Deploy)
* Alpine Linux edge aarch64 (running on Android under Linux Deploy)
## How to build
### Install requirements (Alpine Linux edge)
```
apk add build-base bison flex gawk linux-headers pkgconf readline-static perl
```
### Build
#### iw
`make iw`

#### wpa_supplicant
`wpa_supplicant_build_config` file contains minimal wpa_supplicant build configuration with built-in cryptographic engine (does not depend on OpenSSL). Edit this file according to your needs, then run:  
`make wpa_supplicant`  
Note: if you want to use OpenSSL, firstly build it with `make openssl` then add to the wpa_supplicant config following (change the path to prefix directory):  
```
CFLAGS += -I/the/absolute/path/to/the/prefix/include
LIBS += -lcrypto -lssl
```
#### iw and wpa_supplicant both (excluding openssl)
`make`  
### Once built, the executables will be located in the `binaries/` folder