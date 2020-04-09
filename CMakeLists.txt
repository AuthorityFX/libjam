cmake_minimum_required(VERSION 3.0)
project(jammage_station)

option(FORCE_COLORED_OUTPUT "Always produce ANSI-colored output (GNU/Clang only)." TRUE)
if (${FORCE_COLORED_OUTPUT})
  if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    add_compile_options (-fdiagnostics-color=always)
  elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    add_compile_options (-fcolor-diagnostics)
  endif ()
endif ()

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_C_FLAGS} -O2 -DNDEBUG -Wall")
endif()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(PACKAGE_TESTS "Build the tests" ON)
if(PACKAGE_TESTS)
  enable_testing()
  include(GoogleTest)
  add_subdirectory(tests)
endif()

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/external/GSL/include)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

add_library(jam SHARED src/jam.cpp)
