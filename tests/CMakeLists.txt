enable_testing()

set(CMAKE_CTEST_COMMAND ctest -V)
add_custom_target(tests COMMAND ${CMAKE_CTEST_COMMAND})

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

link_directories(${PROJECT_BINARY_DIR})

add_executable(jam_tests jam_tests.cpp)
target_link_libraries(jam_tests jam)
add_dependencies(tests jam_tests)
add_test(tests ${CMAKE_CURRENT_BINARY_DIR}/jam_tests)
