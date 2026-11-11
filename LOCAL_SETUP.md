# 本机开发环境

项目使用 Linux、C++20 和 io_uring。本机已有 GCC 15.2、CMake 4.2.3、
Python 3.14 和 PyYAML 6.0.3；Git 子模块已按项目锁定的提交初始化。

liburing 2.10 从项目子模块编译安装到 `~/.local/opt/tinycorolab`。
Valgrind 3.26 从当前 Ubuntu 软件源下载并解包到同一目录。
Rust 1.99.1 工具链安装在 `~/.cargo` 和 `~/.rustup`。

已完成验证：项目库、全部示例、实验测试、性能测试和压测程序均可编译；
Rust `echo_bench --help` 正常运行；io_uring 初始化、提交和完成回收实测成功。
CTest 已发现 225 项测试，本次仅运行 `TaskTest.SelfDestroy`、
`TaskTest.VoidTaskCase1`、`TaskTest.VoidTaskCase2` 三项基础测试，全部通过，
且 Valgrind 报告零内存错误、零泄漏。未执行依赖待完成实验代码的完整测试集。

## 日常使用

每次新开终端后，在项目根目录执行：

```bash
source scripts/env.sh
cmake --build build -j4
```

`scripts/env.sh` 为当前终端设置 Rust、Valgrind 和依赖查找路径。
构建目录已经保存编译器、liburing 头文件和静态库路径；采用静态链接，
运行生成的程序无需设置 `LD_LIBRARY_PATH`。

编译实验测试、性能测试和网络压测工具：

```bash
cmake --build build --target build-tests build-benchtests build-bench build-benchtools -j4
```

完成对应实验后运行测试，例如：

```bash
cmake --build build --target test-lab1
cmake --build build --target memtest-lab1
```

当前代码是实验模板，包含 `TODO[lab...]`。编译成功并不代表各项实验已经完成；
功能测试和示例的正确行为依赖于相应实验的实现。

## 重新生成构建目录

如果删除了 `build`，在项目根目录执行：

```bash
source scripts/env.sh
cmake -S . -B build \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_CXX_FLAGS="-isystem $TINYCORO_DEPS/include" \
  -DURING_PATH="$TINYCORO_DEPS/lib/liburing.a"
cmake --build build -j4
```

如果需要重新安装 liburing：

```bash
git submodule update --init --recursive
source scripts/env.sh
(
  cd third_party/liburing
  ./configure --cc=gcc --cxx=g++ --prefix="$TINYCORO_DEPS"
  make -C src -j4
  make liburing.pc
  make -C src install
  install -Dm644 liburing.pc "$TINYCORO_DEPS/lib/pkgconfig/liburing.pc"
)
```
