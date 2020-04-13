enable_testing()

add_subdirectory(
  "${PROJECT_SOURCE_DIR}/external/googletest" "external/googletest"
)

# add test suite with link to jam
macro(ADD_JAM_TEST test_name)
  add_executable(${test_name} ${ARGN})
  target_link_libraries(${test_name} PRIVATE jam gsl gtest gmock gtest_main)
  # https://cmake.org/cmake/help/v3.10/module/GoogleTest.html#command:gtest_disc
  # over_tests
  gtest_discover_tests(
    ${test_name} WORKING_DIRECTORY ${PROJECT_DIR} PROPERTIES
    VS_DEBUGGER_WORKING_DIRECTORY "${PROJECT_DIR}"
  )
  set_target_properties(${test_name} PROPERTIES FOLDER tests)
endmacro()

add_jam_test(jam_tests jam.cpp)
