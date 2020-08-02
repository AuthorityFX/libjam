# ==============================================================================
# libjam - C++ library for jamming over SIP protocol
#
# Copyright (C) 2020, Ryan P. Wilson Authority FX, Inc. www.authorityfx.com
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <https://www.gnu.org/licenses/>.
# ==============================================================================

include(FetchContent)

FetchContent_Declare(
  pjproject
  GIT_REPOSITORY https://github.com/pjsip/pjproject.git
  GIT_TAG 2.10
  GIT_PROGRESS True
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

list(
  APPEND
  opus_includes
  "${PROJECT_BINARY_DIR}/external/opus/include/opus_custom.h"
  "${PROJECT_BINARY_DIR}/external/opus/include/opus_defines.h"
  "${PROJECT_BINARY_DIR}/external/opus/include/opus_multistream.h"
  "${PROJECT_BINARY_DIR}/external/opus/include/opus_projection.h"
  "${PROJECT_BINARY_DIR}/external/opus/include/opus_types.h"
  "${PROJECT_BINARY_DIR}/external/opus/include/opus.h"
)

add_custom_target(pjproject DEPENDS ${opus_includes} ${pj_libraries})

# include opus git submodule
add_subdirectory("${PROJECT_SOURCE_DIR}/external/opus")
# add opus library as a dependency to pjproject target
add_dependencies(pjproject opus)

add_custom_command(
  OUTPUT ${opus_includes}
  COMMAND mkdir -p ${PROJECT_BINARY_DIR}/external/opus/include/opus
  COMMAND cp -r "${PROJECT_SOURCE_DIR}/external/opus/include/."
          ${PROJECT_BINARY_DIR}/external/opus/include/opus
  COMMENT "Copy Opus includes to build"
  USES_TERMINAL VERBATIM
)

set(_cflags "")
list(PREPEND _cflags "-fPIC")
if(CMAKE_C_COMPILER_ID STREQUAL "Clang")

endif()
list(JOIN _cflags " " _cflags)

add_custom_command(
  OUTPUT ${pj_libraries}
  COMMAND
    ${CMAKE_COMMAND} -E env CC=${CMAKE_C_COMPILER} CFLAGS=${_cflags} ./configure
    --disable-video --disable-g711-codec --disable-l16-codec --disable-gsm-codec
    --disable-g722-codec --disable-g7221-codec --disable-sdl --disable-ffmpeg
    --disable-v4l2 --disable-openh264 --disable-vpx --disable-darwin-ssl
    --disable-opencore-amr --disable-silk --disable-bcg729 --disable-libyuv
    --disable-libwebrtc --with-opus=${PROJECT_BINARY_DIR}/external/opus
  COMMAND make dep
  COMMAND make clean
  COMMAND make
  WORKING_DIRECTORY ${pjproject_SOURCE_DIR}
  COMMENT "Build pjproject"
  USES_TERMINAL VERBATIM
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
  target_include_directories(
    ${_args_NAME} INTERFACE "${pjproject_SOURCE_DIR}/${_args_NAME}/include"
  )
  add_dependencies(${_args_NAME} pjproject)
endmacro()

add_pj_library(NAME pjlib)
add_pj_library(NAME pjlib-util)
add_pj_library(NAME pjsip)
add_pj_library(NAME pjnath)
add_pj_library(NAME pjmedia)
