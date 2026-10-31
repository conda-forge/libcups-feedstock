# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .
if [[ "$target_platform" == linux* ]]; then
    export LIBS="-lrt"
fi

# CUPS uses AC_PATH_PROG, which only honors absolute tool overrides.
export AR="$(command -v "${AR}")"
export LD="$(command -v "${LD}")"

./configure --prefix=$PREFIX --with-components=core --libdir=$PREFIX/lib --includedir=$PREFIX/include \
    --enable-gssapi --with-tls=openssl
make -j${CPU_COUNT}
#fails due to some network issue
#make check
make install
