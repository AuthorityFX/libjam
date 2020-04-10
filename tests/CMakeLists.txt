enable_testing()

add_subdirectory(
  "${PROJECT_SOURCE_DIR}/external/googletest" "external/googletest"
)

include_directories(${PROJECT_SOURCE_DIR}/external/GSL/include)

# keeps cache cleaner
mark_as_advanced(
  BUILD_GMOCK
  BUILD_GTEST
  BUILD_SHARED_LIBS
  gmock_build_tests
  gtest_build_samples
  gtest_build_tests
  gtest_disable_pthreads
  gtest_force_shared_crt
  gtest_hide_internal_symbols
)

# add test suite with link to jam
macro(ADD_JAM_TEST test_name)
  include_directories(${PROJECT_SOURCE_DIR}/include)
  link_directories(${PROJECT_BINARY_DIR})
  add_executable(${test_name} ${ARGN})
  target_link_libraries(${test_name} jam gtest gmock gtest_main)
  # https://cmake.org/cmake/help/v3.10/module/GoogleTest.html#command:gtest_disc
  # over_tests
  gtest_discover_tests(
    ${test_name} WORKING_DIRECTORY ${PROJECT_DIR} PROPERTIES
    VS_DEBUGGER_WORKING_DIRECTORY "${PROJECT_DIR}"
  )
  set_target_properties(${test_name} PROPERTIES FOLDER tests)
endmacro()

add_jam_test(jam_tests jam.cpp)
