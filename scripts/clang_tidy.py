#!/usr/bin/env python

import os.path
import argparse
import subprocess
from typing import Optional
from typing import Sequence


def main(argv: Optional[Sequence[str]] = None) -> int:
    parser = argparse.ArgumentParser(description='C++ linter')
    parser.add_argument('filenames', nargs='*', help='Filenames to lint')
    args = parser.parse_args(argv)

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
