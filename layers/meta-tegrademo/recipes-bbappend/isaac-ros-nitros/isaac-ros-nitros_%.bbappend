FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
SRC_URI += "\
    file://libcudacxx_aarch64_cuda_11_4.diff \
"

# https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_nitros/issues/19
do_patch(){
    :
}
do_compile:prepend(){
    patch -N -i ${WORKDIR}/libcudacxx_aarch64_cuda_11_4.diff ${STAGING_DIR_HOST}/usr/local/cuda-11.4/include/cuda/std/detail/libcxx/include/cmath
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

SRCREV = "b3ea5c3221b2013da74787077354e4bfb3ab641e"

# vpi2
VPI_PREFIX = "/opt/nvidia/vpi2"
FILES:${PN} += "${VPI_PREFIX}"
EXTRA_OECMAKE += "-Dvpi_DIR=${STAGING_DIR_HOST}${VPI_PREFIX}/lib/aarch64-linux-gnu/cmake/vpi"

inherit fix-ros