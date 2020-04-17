#!/usr/bin/env python3

import multiprocessing
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
