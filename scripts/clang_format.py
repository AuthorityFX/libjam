#!/usr/bin/env python3

import argparse
import subprocess
from typing import Optional
from typing import Sequence


def main(argv: Optional[Sequence[str]] = None) -> int:
    parser = argparse.ArgumentParser(description='C++ formatter')
    parser.add_argument('filenames', nargs='*', help='Filenames to format')
    args = parser.parse_args(argv)

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
