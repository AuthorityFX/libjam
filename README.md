# Jammage Station

### Requirements

* CMake
* python3
* pip
* clang
* clang-tidy
* clang-format

#### Possible issues during installation:

- `ModuleNotFoundError: No module named '_sqlite3'`
	1. install libsqlite3-dev: sudo apt install libsqlite3-dev
	2. Re-configure and re-compiled Python with `./configure --enable-loadable-sqlite-extensions && make && sudo make install`


- `The source directory {directory} does not contain a CMakeLists.txt file.`
	1. Run `git submodule update --init` in the project directory.
