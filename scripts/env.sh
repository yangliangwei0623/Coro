#!/usr/bin/env bash
# 在项目根目录执行：source scripts/env.sh
export TINYCORO_DEPS="$HOME/.local/opt/tinycorolab"
export PATH="$TINYCORO_DEPS/usr/bin:$HOME/.cargo/bin:$PATH"
export VALGRIND_LIB="$TINYCORO_DEPS/usr/libexec/valgrind"
export CMAKE_PREFIX_PATH="$TINYCORO_DEPS${CMAKE_PREFIX_PATH:+:$CMAKE_PREFIX_PATH}"
export PKG_CONFIG_PATH="$TINYCORO_DEPS/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
