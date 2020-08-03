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


class ClangFormatArgsParser(Tap):
    filenames: List[str]

    def add_arguments(self) -> None:
        self.add_argument('filenames')


def main() -> int:
    args = ClangFormatArgsParser().parse_args()
    command = ["clang-format"]
    # -i - Inplace edit <file>s, if specified.
    command.append('-i')
    # --style=<string>
    # Coding style, currently supports:
    # LLVM, Google, Chromium, Mozilla, WebKit.
    # Use -style=file to load style configuration from
    # .clang-format file located in one of the parent
    # directories of the source file (or current
    # directory for stdin).
    # Use -style="{key: value, ...}" to set specific
    # parameters, e.g.:
    #  -style="{BasedOnStyle: llvm, IndentWidth: 8}"
    command.append('--style=file')
    command.extend(args.filenames)

    return subprocess.call(command)


if __name__ == '__main__':
    exit(main())
