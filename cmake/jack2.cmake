include(FetchContent)

FetchContent_Declare(
  jack2
  GIT_REPOSITORY https://github.com/jackaudio/jack2.git
  GIT_TAG v1.9.14
)

FetchContent_MakeAvailable(jack2)

add_custom_target(jack2 DEPENDS "${jack2_BINARY_DIR}/include/jack/jack.h")

include(ProcessorCount)
processorcount(N)

set(_cflags "")
set(_cxxflags "")
set(_linker_flags "")
list(
  APPEND
  _cflags
  "-march=x86-64"
  "-mtune=generic"
  "-O3"
  "-pipe"
  "-fno-plt"
  "-Wall"
  "-D_FORTIFY_SOURCE=2"
)
list(APPEND _cxxflags ${_cflags} "std=gnu++11")
list(APPEND _linker_flags "-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now")
if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  list(PREPEND _cflags "-flto=thin")
  list(PREPEND _cxxflags "-flto=thin")
  list(PREPEND _linker_flags "-fuse-ld=lld")
endif()
list(JOIN _cflags " " _cflags)
list(JOIN _cxxflags " " _cxxflags)
list(JOIN _linker_flags " " _linker_flags)

add_custom_command(
  OUTPUT "${jack2_BINARY_DIR}/include/jack/jack.h"
  COMMAND
    ${CMAKE_COMMAND} -E env CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER}
    CFLAGS=${_cflags} CXXFLAGS=${_cflags} LDFLAGS=${_linker_flags} ./waf
    configure "--prefix=${jack2_BINARY_DIR}" "-j${N}" --doxygen=no --alsa=yes
  COMMAND ./waf
  COMMAND ./waf install
  COMMAND_EXPAND_LISTS
  WORKING_DIRECTORY ${jack2_SOURCE_DIR}
  COMMENT "Build jack2"
  USES_TERMINAL VERBATIM
)

find_library(
  jack_LIB
  NAMES jack
  PATHS "${jack2_BINARY_DIR}/lib/"
  DOC "Find jack library"
)

add_library(jack SHARED IMPORTED GLOBAL)
set_target_properties(jack PROPERTIES IMPORTED_LOCATION "${jack_LIB}")
target_include_directories(jack INTERFACE "${jack2_SOURCE_DIR}/common")
add_dependencies(jack jack2)
