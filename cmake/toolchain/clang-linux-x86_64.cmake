set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86_64)
set(CMAKE_CROSSCOMPILING FALSE)

set(tools /usr/bin)
set(CMAKE_C_COMPILER ${tools}/clang)
set(CMAKE_CXX_COMPILER ${tools}/clang++)

set(CMAKE_LINKER ${tools}/lld-9)

set(CMAKE_C_AR ${tools}/llvm-ar)
set(CMAKE_CXX_AR ${tools}/llvm-ar)
set(CMAKE_C_RANLIB ${tools}/llvm-ranlib)
set(CMAKE_CXX_RANLIB ${tools}/llvm-ranlib)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
