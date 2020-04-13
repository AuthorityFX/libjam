cmake_minimum_required(VERSION 3.11)
project(jammage_station)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

# Set force colored output for prettify Ninja output
include(force_colored_output)
force_colored_output()

# Install pre-commit python package
include(install_pre_commit)
install_pre_commit()

# Generate compile_commands database
include(compdb)

# TODO: move to cmake directory
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_C_FLAGS} -O2 -DNDEBUG -Wall")
endif()

# TODO: move to cmake directory
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(PACKAGE_TESTS "Build the tests" ON)
if(PACKAGE_TESTS)
  enable_testing()
  include(GoogleTest)
  add_subdirectory(tests)
endif()

# TODO: move to cmake directory
add_library(gsl INTERFACE)
target_include_directories(
  gsl
  PRIVATE
  INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/external/GSL/include
)

# Include pjproject for SIP libs
include(pjproject)

add_library(jam SHARED src/jam.cpp)
target_include_directories(jam PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_link_libraries(jam PRIVATE pjlib pjlib-util pjsip)
target_link_libraries(jam PRIVATE gsl)
