include(FetchContent)

FetchContent_Declare(
  jack2
  GIT_REPOSITORY https://github.com/jackaudio/jack2.git
  GIT_TAG v1.9.14
)

FetchContent_MakeAvailable(jack2)

set(jack_LIBRARY "${jack2_SOURCE_DIR}/build/common/libjack.so")
list(APPEND jack2_libraries ${jack_LIBRARY})

add_custom_target(jack2 DEPENDS ${jack2_libraries})

include(ProcessorCount)
processorcount(processor_count)

add_custom_command(
  OUTPUT ${jack2_libraries}
  COMMAND
    ${CMAKE_COMMAND} -E env CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER}
    ./waf configure "-j${processor_count}" --doxygen=no --alsa=yes
  COMMAND ./waf
  COMMAND_EXPAND_LISTS
  WORKING_DIRECTORY ${jack2_SOURCE_DIR}
  COMMENT "Build jack2"
  USES_TERMINAL VERBATIM
)

add_library(jack SHARED IMPORTED GLOBAL)
set_target_properties(jack PROPERTIES IMPORTED_LOCATION "${jack_LIBRARY}")
set_target_properties(
  jack PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${jack2_SOURCE_DIR}/common"
)
add_dependencies(jack jack2)
