include(FetchContent)

FetchContent_Declare(
  pjproject
  GIT_REPOSITORY https://github.com/pjsip/pjproject.git
  GIT_TAG 2.10
)

FetchContent_MakeAvailable(pjproject)

set(pjsip_LIBRARY ${pjproject_SOURCE_DIR}/pjsip/lib/libpjsip-x86_64-pc-none.a)

add_custom_target(pjproject DEPENDS ${pjsip_LIBRARY})

add_custom_command(
  OUTPUT ${pjsip_LIBRARY}
  COMMAND
    ./configure --target=x86_64 --disable-video --disable-bcg729
    --disable-ffmpeg --disable-openh264 --disable-sdl --disable-v4l2
    --disable-vpx --disable-g711-codec --disable-g722-codec
    --disable-g7221-codec --disable-gsm-codec --disable-ilbc-codec
    --disable-l16-codec --disable-large-filter --disable-libwebrtc
    --disable-libyuv --disable-opencore-amr --disable-silk --enable-ext-sound
    --enable-ssl
  COMMAND make dep && make clean && make -j8
  WORKING_DIRECTORY ${pjproject_SOURCE_DIR}
  COMMENT "Build pjproject"
)

add_library(pjsip STATIC IMPORTED GLOBAL)
set_target_properties(pjsip PROPERTIES IMPORTED_LOCATION ${pjsip_LIBRARY})
set_target_properties(
  pjsip PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
                   "${pjproject_SOURCE_DIR}/pjsip/include"
)
add_dependencies(pjsip pjproject)
