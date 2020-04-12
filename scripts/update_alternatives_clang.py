#!/usr/bin/env python3

import argparse
import subprocess
from typing import Optional
from typing import Sequence
from typing import List


class UpdateAlternative():
    def __init__(self, argsv: Optional[Sequence[str]]) -> None:
        parser = argparse.ArgumentParser()
        parser.add_argument('-v', '--version', nargs=1,
                            type=int, help='Clang version')
        parser.add_argument('-p', '--priority', nargs=1,
                            type=int, help='update-alternatives priority')
        args = parser.parse_args(argsv)

        self._version = args.version[0]
        self._priority = args.priority[0]
        self._command = ["update-alternatives"]

    def add_install(self, name: str) -> None:
        self._command.extend(
            ['--install', f'/usr/bin/{name}', name,
                f'/usr/bin/{name}-{self._version}', str(self._priority)]
        )

    def add_slave(self, name: str) -> None:
        self._command.extend(
            ['--slave', f'/usr/bin/{name}', name,
                f'/usr/bin/{name}-{self._version}']
        )

    def install(self) -> int:
        return subprocess.call(self._command)


def main(argv: Optional[Sequence[str]] = None) -> int:
    update_alternative = UpdateAlternative(argv)
    update_alternative.add_install('clang')
    slaves: List[str] = [
        'clang-apply-replacements',
        'clang-change-namespace',
        'clang-check',
        'clang-cl',
        'clang-cpp',
        'clang-doc',
        'clang-format-diff',
        'clang-format',
        'clang-import-test',
        'clang-include-fixer',
        'clang-offload-bundler',
        'clang-query',
        'clang-refactor',
        'clang-rename',
        'clang-reorder-fields',
        'clang-scan-deps',
        'clang-tidy',
        'clang++',
        'clangd',
        'lldb',
    ]
    for slave in slaves:
        update_alternative.add_slave(slave)

    return update_alternative.install()


if __name__ == '__main__':
    exit(main())
