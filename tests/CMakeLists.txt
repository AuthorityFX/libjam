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
