enable_testing()

add_subdirectory("${PROJECT_SOURCE_DIR}/external/googletest" "external/googletest")

# keeps cache cleaner
mark_as_advanced(
  BUILD_GMOCK BUILD_GTEST BUILD_SHARED_LIBS
  gmock_build_tests gtest_build_samples gtest_build_tests
  gtest_disable_pthreads gtest_force_shared_crt gtest_hide_internal_symbols
)

macro(package_add_test TESTNAME)
  add_executable(${TESTNAME} ${ARGN})
  target_link_libraries(${TESTNAME} gtest gmock gtest_main)
  # https://cmake.org/cmake/help/v3.10/module/GoogleTest.html#command:gtest_discover_tests
  gtest_discover_tests(${TESTNAME}
    WORKING_DIRECTORY ${PROJECT_DIR}
    PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "${PROJECT_DIR}"
  )
  set_target_properties(${TESTNAME} PROPERTIES FOLDER tests)
endmacro()

macro(package_add_jam_test TESTNAME)
  include_directories(${PROJECT_SOURCE_DIR}/include)
  link_directories(${PROJECT_BINARY_DIR})
  add_executable(${TESTNAME} ${ARGN})
  target_link_libraries(${TESTNAME} jam gtest gmock gtest_main)
  # https://cmake.org/cmake/help/v3.10/module/GoogleTest.html#command:gtest_discover_tests
  gtest_discover_tests(${TESTNAME}
    WORKING_DIRECTORY ${PROJECT_DIR}
    PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "${PROJECT_DIR}"
  )
  set_target_properties(${TESTNAME} PROPERTIES FOLDER tests)
endmacro()

package_add_jam_test(jam_tests jam.cpp)
