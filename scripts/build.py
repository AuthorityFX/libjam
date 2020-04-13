#!/usr/bin/env python3

import subprocess
import os
from typing import Optional
from typing import Sequence


def main(argv: Optional[Sequence[str]] = None) -> int:
    current_directory = os.path.dirname(os.path.realpath(__file__))
    project_directory = os.path.realpath(
        os.path.join(current_directory, '../'))
    build_directory = os.path.join(project_directory, 'build')

    if (os.path.exists(build_directory) is False):
        os.mkdir(build_directory)

    cmake_command = ['cmake']
    cmake_command.append('-GNinja')
    cmake_command.append('-DCMAKE_C_COMPILER=clang')
    cmake_command.append('-DCMAKE_CXX_COMPILER=clang++')
    cmake_command.append('..')

    return_value: int

    return_value = subprocess.call(cmake_command, cwd=build_directory)
    if (return_value != 0):
        raise Exception("Failed to configure")

    build_command = ['ninja']
    return_value = subprocess.call(build_command, cwd=build_directory)
    if (return_value != 0):
        raise Exception("Failed to build")

    return return_value


if __name__ == '__main__':
    exit(main())
