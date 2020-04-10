cmake_minimum_required(VERSION 3.0)
project(jammage_station)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

include(install_cmake_format)
install_cmake_format()

include(force_colored_output)
force_colored_output()

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_C_FLAGS} -O2 -DNDEBUG -Wall")
endif()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(PACKAGE_TESTS "Build the tests" ON)
if(PACKAGE_TESTS)
  enable_testing()
  include(GoogleTest)
  add_subdirectory(tests)
endif()

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/external/GSL/include)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

add_library(jam SHARED src/jam.cpp)
