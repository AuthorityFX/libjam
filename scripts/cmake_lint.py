#!/usr/bin/env python

import os.path
import argparse
import subprocess
from typing import Optional
from typing import Sequence


def main(argv: Optional[Sequence[str]] = None) -> int:
    parser = argparse.ArgumentParser(description='CMake linter')
    parser.add_argument('filenames', nargs='*', help='Filenames to lint')
    args = parser.parse_args(argv)

    command = ["cmake-lint"]
    command.extend(args.filenames)

    return subprocess.call(command)

if __name__ == '__main__':
    exit(main())
