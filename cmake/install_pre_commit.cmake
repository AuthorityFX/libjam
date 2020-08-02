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

# Install cmake-format using pip
function(install_pre_commit)
  if(${PRE_COMMIT_INSTALLED})
    return()
  endif()
  execute_process(COMMAND pre-commit install RESULT_VARIABLE _return)
  # Throw is return code not 0
  if(NOT _return EQUAL 0)
    message(FATAL_ERROR ${_error})
  endif()
  set(PRE_COMMIT_INSTALLED
      true
      CACHE BOOL "pre-commit is installed"
  )
endfunction()
