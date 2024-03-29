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

import subprocess
from tap import Tap
from typing import List


class ClangTidyArgsParser(Tap):
    filenames: List[str]

    def add_arguments(self) -> None:
        self.add_argument('filenames')


def main() -> int:
    args = ClangTidyArgsParser().parse_args()
    command = ["clang-tidy"]
    # Style for formatting code around applied fixes:
    #   - 'none' (default) turns off formatting
    #   - 'file' (literally 'file', not a placeholder)
    #     uses .clang-format file in the closest parent
    #     directory
    #   - '{ <json> }' specifies options inline, e.g.
    #     -format-style='{BasedOnStyle: llvm, IndentWidth: 8}'
    #   - 'llvm', 'google', 'webkit', 'mozilla'
    # See clang-format documentation for the up-to-date
    # information about formatting styles and options.
    # This option overrides the 'FormatStyle` option in
    # .clang-tidy file, if any.
    command.append('-format-style="file"')
    # Apply suggested fixes. Without -fix-errors
    # clang-tidy will bail out if any compilation
    # errors were found.
    command.append('--fix')
    # -p <build-path> is used to read a compile command database.
    #
    # For example, it can be a CMake build directory in which a file named
    # compile_commands.json exists (use -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
    # CMake option to get this output). When no build path is specified,
    # a search for compile_commands.json will be attempted through all
    # parent paths of the first input file . See:
    # http://clang.llvm.org/docs/HowToSetupToolingForLLVM.html for an
    # example of setting up Clang Tooling on a source tree.
    command.extend(['-p', 'build'])
    command.extend(args.filenames)

    return subprocess.call(command)


if __name__ == '__main__':
    exit(main())
