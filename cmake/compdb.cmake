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

# Generate compile_commands.json
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Add headers to compile_commands.json for use with clang tools
add_custom_target(
  compdb ALL
  DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/compile_commands.json
  COMMENT "custom target"
)
add_custom_command(
  OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/compile_commands.json
  COMMAND compdb -p build/ list > compile_commands.json
  VERBATIM
  DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/compile_commands.json
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
