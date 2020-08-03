#!/usr/bin/env python3

# ==============================================================================
# libjam - C++ library for jamming over SIP protocol
#
# Copyright (C) 2020, Ryan P. Wilson
#   Authority FX, Inc.
#   www.authorityfx.com
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
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
# ==============================================================================

import multiprocessing
import subprocess
import os


def main() -> int:
    current_directory = os.path.dirname(os.path.realpath(__file__))
    project_directory = os.path.realpath(
        os.path.join(current_directory, '../'))
    build_directory = os.path.join(project_directory, 'build')

    if (os.path.exists(build_directory) is False):
        os.mkdir(build_directory)

    toolchain_directory = os.path.join(project_directory, 'cmake/toolchain')

    toolchain = os.path.join(toolchain_directory, 'clang-linux-x86_64.cmake')

    cmake_command = ['cmake']
    # TODO: fPIC linker issue with pjproject
    # cmake_command.append('-GNinja')
    cmake_command.append(f'-DCMAKE_TOOLCHAIN_FILE={toolchain}')
    cmake_command.append('..')

    return_value: int

    return_value = subprocess.call(cmake_command, cwd=build_directory)
    if (return_value != 0):
        raise Exception("Failed to configure")

    build_command = ['make', f'-j{multiprocessing.cpu_count()}']
    return_value = subprocess.call(build_command, cwd=build_directory)
    if (return_value != 0):
        raise Exception("Failed to build")

    test_command = ['make', 'test']
    return_value = subprocess.call(test_command, cwd=build_directory)
    if (return_value != 0):
        raise Exception("Tests failed")

    return return_value


if __name__ == '__main__':
    exit(main())
