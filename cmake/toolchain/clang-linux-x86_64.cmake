set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86_64)
set(CMAKE_CROSSCOMPILING FALSE)

set(tools /usr/bin)

set(CMAKE_C_COMPILER ${tools}/clang)
set(CMAKE_CXX_COMPILER ${tools}/clang++)

# Use LLVM Linker
set(CMAKE_EXE_LINKER_FLAGS "-fuse-ld=lld")
# ThinLTO (thin link time optimization) https://clang.llvm.org/docs/ThinLTO.html
set(CMAKE_CXX_FLAGS "-flto=thin")

set(CMAKE_ADDR2LINE ${tools}/llvm-addr2line)
set(CMAKE_AR ${tools}/llvm-ar)
set(CMAKE_NM ${tools}/llvm-nm)
set(CMAKE_OBJCOPY ${tools}/llvm-objcopy)
set(CMAKE_OBJDUMP ${tools}/llvm-objdump)
set(CMAKE_RANLIB ${tools}/llvm-ranlib)
set(CMAKE_READELF ${tools}/llvm-readelf)
set(CMAKE_STRIP ${tools}/llvm-strip)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
