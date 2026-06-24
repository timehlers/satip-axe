# minisatip v2 with AXE and SRT

This fork builds minisatip from the v2 codebase and applies a local AXE
compatibility patch during the build:

```text
patches/minisatip-v2-axe-sh4.patch
```

The patch adds:

- `AXE=ON` CMake support
- AXE tuner/platform handling
- small C++11 compatibility headers for the STLinux SH4 GCC 4.8.4 toolchain
- fixes needed to build minisatip v2 without C++23

SRT is built from SRT 1.4.4 and patched for the same SH4 toolchain:

```text
patches/srt-1.4.4-sh4.patch
```

## Build

The `minisatip` make target now performs these steps:

1. generate an SH4 CMake toolchain file in `apps/sh4-toolchain.cmake`
2. clone and patch SRT 1.4.4
3. build and install SRT into `apps/srt-install`
4. clone and patch minisatip v2
5. build minisatip with `AXE=ON`, `SRT=ON`, `CXX23=OFF`

The tested minisatip configuration disables DVB-CSA and DVBCA:

```text
DVBCSA=OFF
DVBCA=OFF
```

## Runtime libraries

The firmware image includes the additional runtime libraries required by the
SRT-enabled minisatip binary:

```text
/lib/libsrt.so.1.4.4
/lib/libsrt.so.1.4
/lib/libatomic.so.1.0.0
/lib/libatomic.so.1
```

On the tested AXE device, the existing firmware already contained compatible
copies of:

```text
/usr/lib/libstdc++.so.6
/lib/libgcc_s.so.1
```

## Tested

- SH4 build with the STLinux 2.4 toolchain
- minisatip v2 starts on AXE hardware
- SAT>IP client playback works
- `libsrt.so.1.4.4` and `libatomic.so.1.0.0` are loaded at runtime

End-to-end SRT streaming still needs runtime testing.
