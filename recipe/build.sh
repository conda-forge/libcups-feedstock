# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .
if [[ "$target_platform" == linux* ]]; then
    export LIBS="-lrt"
fi

./configure --prefix=$PREFIX --with-components=core --libdir=$PREFIX/lib --includedir=$PREFIX/include
make -j${CPU_COUNT}
#fails due to some network issue
#make check
make install
