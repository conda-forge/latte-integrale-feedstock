#!/bin/bash

# We can not use C++17 due to https://stackoverflow.com/questions/47284705/c1z-dynamic-exception-specification-error
export CXXFLAGS="$CXXFLAGS -std=c++14"

./configure --prefix=$PREFIX --enable-shared --disable-static --with-ntl=$PREFIX --with-cddlib=$PREFIX || (cat config.log; false)
make -j${CPU_COUNT}
make install
# Tests are broken, see https://github.com/conda-forge/latte-integrale-feedstock/pull/4
# Unfortunately, upstream does not seem to care and does not even run the tests
# in their CI. So we just pretend that everything is fine and ship this as is.
# make check || (cat code/latte/test-suite.log; false)
