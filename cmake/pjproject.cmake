include(FetchContent)

FetchContent_Declare(
  pjproject
  GIT_REPOSITORY https://github.com/pjsip/pjproject.git
  GIT_TAG 2.10
)

FetchContent_MakeAvailable(pjproject)

add_custom_target(
  pjproject_configure
  COMMAND
    ./configure --target=x86_64 --disable-video --disable-bcg729
    --disable-ffmpeg --disable-openh264 --disable-sdl --disable-v4l2
    --disable-vpx --disable-g711-codec --disable-g722-codec
    --disable-g7221-codec --disable-gsm-codec --disable-ilbc-codec
    --disable-l16-codec --disable-large-filter --disable-libwebrtc
    --disable-libyuv --disable-opencore-amr --disable-silk --enable-ext-sound
    --enable-shared --enable-ssl
  WORKING_DIRECTORY ${pjproject_SOURCE_DIR}
  COMMENT "Cononfigure pjproject"
)

# configur and build pjproject
function(build_pjproject)
  if(${PJPROJECT_BUILT})
    return()
  endif()

  FetchContent_GetProperties(pjproject)

  # configure pjproject
  execute_process(
    COMMAND
      ./configure
      # --target=x86_64 --disable-video --disable-bcg729 --disable-ffmpeg
      # --disable-openh264 --disable-sdl --disable-v4l2 --disable-vpx
      # --disable-g711-codec --disable-g722-codec --disable-g7221-codec
      # --disable-gsm-codec --disable-ilbc-codec --disable-l16-codec --disable-
      # large-filter --disable-libwebrtc --disable-libyuv --disable-opencore-amr
      # --disable-silk --enable-ext-sound --enable-shared --enable-ssl
    WORKING_DIRECTORY ${pjproject_SOURCE_DIR}
    RESULT_VARIABLE _return
  )
  # Throw is return code not 0
  if(NOT _return EQUAL 0)
    message(FATAL_ERROR ${_error})
  endif()

  # build pjproject
  execute_process(
    COMMAND make dep && make clean && make -j8
    WORKING_DIRECTORY ${pjproject_SOURCE_DIR}
    RESULT_VARIABLE _return
  )
  # Throw is return code not 0
  if(NOT _return EQUAL 0)
    message(FATAL_ERROR ${_error})
  endif()

  # set PJPROJECT_BUILT variable
  set(PJPROJECT_BUILT
      true
      CACHE BOOL "pjproject is installed"
  )
endfunction()

build_pjproject()

find_library(
  pjsip_LIBRARY
  NAMES pjsip pjsip-x86_64
  PATHS ${SOURCE_DIR}
  PATH_SUFFIXES pjsip/lib/
  NO_DEFAULT_PATH
)

add_library(pjsip STATIC IMPORTED IMPORTED_LOCATION ${pjsip_LIBRARY})
# add_dependencies(pjsip pjproject_configure)
