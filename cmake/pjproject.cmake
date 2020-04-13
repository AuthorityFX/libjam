include(FetchContent)

FetchContent_Declare(
  pjproject
  GIT_REPOSITORY https://github.com/pjsip/pjproject.git
  GIT_TAG 2.10
)

FetchContent_MakeAvailable(pjproject)

set(pj_target "x86_64-pc-none")

set(pjlib_LIBRARY "${pjproject_SOURCE_DIR}/pjlib/lib/libpj-${pj_target}.a")
set(pjlib-util_LIBRARY
    "${pjproject_SOURCE_DIR}/pjlib-util/lib/libpjlib-util-${pj_target}.a"
)
set(pjsip_LIBRARY "${pjproject_SOURCE_DIR}/pjsip/lib/libpjsip-${pj_target}.a")
list(APPEND pj_libraries ${pjlib_LIBRARY})
list(APPEND pj_libraries ${pjlib-util_LIBRARY})
list(APPEND pj_libraries ${pjsip_LIBRARY})

add_custom_target(pjproject DEPENDS ${pj_libraries})

add_custom_command(
  OUTPUT ${pj_libraries}
  COMMAND
    ./configure --target=x86_64 --disable-video --disable-bcg729
    --disable-ffmpeg --disable-openh264 --disable-sdl --disable-v4l2
    --disable-vpx --disable-g711-codec --disable-g722-codec
    --disable-g7221-codec --disable-gsm-codec --disable-ilbc-codec
    --disable-l16-codec --disable-large-filter --disable-libwebrtc
    --disable-libyuv --disable-opencore-amr --disable-silk --enable-ext-sound
    --enable-ssl
  COMMAND make dep && make clean && make -j8
  COMMAND make -j8
  WORKING_DIRECTORY ${pjproject_SOURCE_DIR}
  COMMENT "Build pjproject"
)

# Create IMPORTED library for pjproject library
macro(add_pj_library)
  cmake_parse_arguments(_args "NO_LIB" "NAME" "" ${ARGN})
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
