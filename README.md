# libjam

### Requirements

* CMake
* python3
* pip
* virtualenv
* clang
* clang-tidy
* clang-format

### How to build

Install Git submodules
```bash
git submodule update --init
```

Install python virtualenv
```bash
./scripts/install_virtualenv.sh
```

Setup virtual env
```bash
./scripts/setup_virtualenv.sh
source .env/bin/activate
```

Build via script
```bash
./scripts/build.py
```

Build
```bash
mkdir build
cd build
cmake ..
make -j8 # or make -j$(nproc)
make test
```

### Possible issues during installation:

- `ModuleNotFoundError: No module named '_sqlite3'`
	1. install libsqlite3-dev: sudo apt install libsqlite3-dev
	2. Re-configure and re-compiled Python with `./configure --enable-loadable-sqlite-extensions && make && sudo make install`
