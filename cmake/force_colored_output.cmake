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

# Force colored output for prettier Ninja console logging
function(force_colored_output)
  option(FORCE_COLORED_OUTPUT
         "Always produce ANSI-colored output (GNU/Clang only)." TRUE
  )
  if(${FORCE_COLORED_OUTPUT})
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
      add_compile_options(-fdiagnostics-color=always)
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
      add_compile_options(-fcolor-diagnostics)
    endif()
  endif()
endfunction()
