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


class UpdateAlternativeArgsParser(Tap):
    version: int
    '''Clang version'''
    priority: int
    '''update-alternatives priority'''

    def add_arguments(self) -> None:
        self.add_argument('-v', '--version')
        self.add_argument('-p', '--priority')


class UpdateAlternative():
    def __init__(self) -> None:
        args = UpdateAlternativeArgsParser().parse_args()
        self._version = args.version
        self._priority = args.priority
        self._command = ["update-alternatives"]

    def add_install(self, name: str) -> None:
        self._command.extend(
            ['--install', f'/usr/bin/{name}', name,
                f'/usr/bin/{name}-{self._version}', str(self._priority)]
        )

    def add_slave(self, slave: str) -> None:
        self._command.extend(
            ['--slave', f'/usr/bin/{slave}', slave,
                f'/usr/bin/{slave}-{self._version}']
        )

    def add_slaves(self, slaves: List[str]) -> None:
        for slave in slaves:
            self.add_slave(slave)

    def install(self) -> int:
        return subprocess.call(self._command)


def main() -> int:
    return_value: int

    clang_alternative = UpdateAlternative()
    clang_alternative.add_install('clang')
    clang_alternative.add_slaves([
        'clang++',
        'clangd',
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
        'lldb',
    ])
    return_value = clang_alternative.install()
    if(return_value != 0):
        return return_value

    llvm_alternative = UpdateAlternative()
    llvm_alternative.add_install('llvm-config')
    llvm_alternative.add_slaves([
        'lld',
        'lli-child-target',
        'llvm-addr2line',
        'llvm-ar',
        'llvm-as',
        'llvm-bcanalyzer',
        'llvm-c-test',
        'llvm-cat',
        'llvm-cfi-verify',
        'llvm-cov',
        'llvm-cvtres',
        'llvm-cxxdump',
        'llvm-cxxfilt',
        'llvm-cxxmap',
        'llvm-diff',
        'llvm-dis',
        'llvm-dlltool',
        'llvm-dwarfdump',
        'llvm-dwp',
        'llvm-elfabi',
        'llvm-exegesis',
        'llvm-extract',
        'llvm-jitlink',
        'llvm-lib',
        'llvm-link',
        'llvm-lipo',
        'llvm-lto',
        'llvm-lto2',
        'llvm-mc',
        'llvm-mca',
        'llvm-modextract',
        'llvm-mt',
        'llvm-nm',
        'llvm-objcopy',
        'llvm-objdump',
        'llvm-opt-report',
        'llvm-pdbutil',
        'llvm-PerfectShuffle',
        'llvm-profdata',
        'llvm-ranlib',
        'llvm-rc',
        'llvm-readelf',
        'llvm-readobj',
        'llvm-rtdyld',
        'llvm-size',
        'llvm-split',
        'llvm-stress',
        'llvm-strings',
        'llvm-strip',
        'llvm-symbolizer',
        'llvm-tblgen',
        'llvm-undname',
        'llvm-xray',
    ])
    return llvm_alternative.install()


if __name__ == '__main__':
    exit(main())
