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

add_custom_command(
  OUTPUT "${jack2_BINARY_DIR}/include/jack/jack.h"
  COMMAND
    ${CMAKE_COMMAND} -E env CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER}
    ./waf configure "--prefix=${jack2_BINARY_DIR}" "-j${N}" --doxygen=no
    --alsa=yes
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
