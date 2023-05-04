FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
SRC_URI += "\
    file://libcudacxx_aarch64_cuda_11_4.diff \
"

# https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_nitros/issues/19
do_patch(){
    :
}
do_compile:prepend(){
    patch -t -i ${WORKDIR}/libcudacxx_aarch64_cuda_11_4.diff ${STAGING_DIR_HOST}/usr/local/cuda-11.4/include/cuda/std/detail/libcxx/include/cmath
}

# do_patch:append() {
#     bb.build.exec_func('do_sed_paths', d)
# }

# do_sed_paths() {
#     sed -i -e 's|tests/||' ${S}/memcheck/tests/badfree3.stderr.exp
#     sed -i -e 's|tests/||' ${S}/memcheck/tests/varinfo5.stderr.exp
# }

ROS_BUILDTOOL_DEPENDS += " \
    ament-cmake-auto-native \
    rosidl-adapter-native \
"

ROS_BUILD_DEPENDS += " \
    libeigen \
    libnvvpi2 \
    ament-lint-auto \
    launch-testing-ament-cmake \
    yaml-cpp \
    cuda-nvtx \
"


inherit fix-ros