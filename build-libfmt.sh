#!/bin/bash

source /app/bash-simplify/_importBSFn.sh
source /app/bash-simplify/cdCurScriptDir.sh
cdCurScriptDir

source /app/bash-simplify/git_Clone_SwitchTag.sh
source /app/bash-simplify/cmakeInstall.sh

REPO_HOME="/app/fmtlib-fmt"
BUILD_HOME="$REPO_HOME/build"
LibFmtArchiv="$BUILD_HOME/libfmt.a"
_CXX__FLAG=" -fno-omit-frame-pointer -Wall   -O0  -fPIC "

#1. 下载git仓库 fmt.git
#https://github.com/fmtlib/fmt.git
git_Clone_SwitchTag http://giteaz:3000/util/fmtlib-fmt.git tag__10.0.0 $REPO_HOME

# set +x
#2. 编译 fmt

function _reBuild_fmt() {
cmakeInstall && \
echo $BUILD_HOME && rm -fr $BUILD_HOME && mkdir $BUILD_HOME && \
cmake -S $REPO_HOME -B $BUILD_HOME \
-DFMT_TEST=OFF \
-DCMAKE_CXX_FLAGS="$_CXX__FLAG"  -DCMAKE_C_FLAGS="$_CXX__FLAG" \
-S $REPO_HOME && \

make -j8 && \

echo "编译产物如下:" && \
ls -lh $LibFmtArchiv && file $LibFmtArchiv && \

}



[[ ! -f $LibFmtArchiv ]] && _reBuild_fmt