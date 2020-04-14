include(FetchContent)

FetchContent_Declare(
  pjproject
  GIT_REPOSITORY https://github.com/pjsip/pjproject.git
  GIT_TAG 2.10
)

FetchContent_MakeAvailable(pjproject)

set(pj_target "x86_64-unknown-linux-gnu")

set(pjlib_LIBRARY "${pjproject_SOURCE_DIR}/pjlib/lib/libpj-${pj_target}.a")
set(pjlib-util_LIBRARY
    "${pjproject_SOURCE_DIR}/pjlib-util/lib/libpjlib-util-${pj_target}.a"
)
set(pjsip_LIBRARY "${pjproject_SOURCE_DIR}/pjsip/lib/libpjsip-${pj_target}.a")
set(pjnath_LIBRARY
    "${pjproject_SOURCE_DIR}/pjnath/lib/libpjnath-${pj_target}.a"
)
set(pjmedia_LIBRARY
    "${pjproject_SOURCE_DIR}/pjmedia/lib/libpjmedia-${pj_target}.a"
)
list(APPEND pj_libraries ${pjlib_LIBRARY})
list(APPEND pj_libraries ${pjlib-util_LIBRARY})
list(APPEND pj_libraries ${pjsip_LIBRARY})
list(APPEND pj_libraries ${pjnath_LIBRARY})
list(APPEND pj_libraries ${pjmedia_LIBRARY})

add_custom_target(pjproject DEPENDS ${pj_libraries})

set_target_properties(
  pjproject PROPERTIES RULE_LAUNCH_CUSTOM
                       [=[env CFLAGS="-fPIC" CPPFLAGS="-fPIC"]=]
)

add_custom_command(
  OUTPUT ${pj_libraries}
  COMMAND ./configure
  COMMAND make dep
  COMMAND make clean
  COMMAND make
  WORKING_DIRECTORY ${pjproject_SOURCE_DIR}
  COMMENT "Build pjproject"
  USES_TERMINAL
)

# Create IMPORTED library for pjproject library
macro(add_pj_library)
  cmake_parse_arguments(_args "" "NAME" "" ${ARGN})
  if(NOT _args_NAME)
    message(FATAL_ERROR "'NAME' keyword argument missing")
  endif()
  add_library(${_args_NAME} STATIC IMPORTED GLOBAL)
  set_target_properties(
    ${_args_NAME} PROPERTIES IMPORTED_LOCATION "${${_args_NAME}_LIBRARY}"
  )
  set_target_properties(
    ${_args_NAME} PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
                             "${pjproject_SOURCE_DIR}/${_args_NAME}/include"
  )
  add_dependencies(${_args_NAME} pjproject)
endmacro()

add_pj_library(NAME pjlib)
add_pj_library(NAME pjlib-util)
add_pj_library(NAME pjsip)
add_pj_library(NAME pjnath)
add_pj_library(NAME pjmedia)
