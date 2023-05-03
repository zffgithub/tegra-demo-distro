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

# EXTRA_OECMAKE += "-DCMAKE_MODULE_PATH:PATH=${STAGING_DIR_HOST}/usr/share/isaac_ros_gxf/cmake/modules;${STAGING_DIR_HOST}/usr/lib/cmake/yaml-cpp"

VPI_PREFIX = "/opt/nvidia/vpi2"
FILES:${PN} += "${VPI_PREFIX}"
EXTRA_OECMAKE += "-Dvpi_DIR=${STAGING_DIR_HOST}${VPI_PREFIX}/lib/aarch64-linux-gnu/cmake/vpi"

# EXTRA_OECMAKE += "-DGXF_DIR=${STAGING_DIR_HOST}/usr/share/isaac_ros_gxf/cmake/modules"

EXTRA_OECMAKE += "-DCMAKE_MODULE_PATH:PATH=${STAGING_DIR_HOST}/usr/share/isaac_ros_gxf/cmake/modules"
# EXTRA_OECMAKE += "-DYamlCpp_DIR=${STAGING_DIR_HOST}/usr/lib/cmake/yaml-cpp"

EXTRA_OECMAKE += "-DCUDA_TOOLKIT_ROOT_DIR=${STAGING_DIR_HOST}/usr/local/cuda-11.4"
EXTRA_OECMAKE += "-DSTAGING_DIR_HOST=${STAGING_DIR_HOST}"

# isaac-ros-nitros-1.0-r0 do_package_qa: QA Issue: non -staticdev package contains static .a library: isaac-ros-nitros path '/usr/share/isaac_ros_nitros/nvapriltags/lib_x86_64_cuda_11_8/libapril_tagging.a'
INSANE_SKIP:${PN} += "staticdev"

# DEPENDS:append:class-target = " chrpath-replacement-native"
# For some reason ends with bad RPATH
# WARNING: suitesparse-amd-2.4.6-r0 do_package_qa: QA Issue: package suitesparse-amd contains bad RPATH /jenkins/mjansa/build-ros/ros2-dashing-master/tmp-glibc/work/core2-32-oe-linux/suitesparse-amd/2.4.6-r0/image/usr/lib in file /jenkins/mjansa/build-ros/ros2-dashing-master/tmp-glibc/work/core2-32-oe-linux/suitesparse-amd/2.4.6-r0/packages-split/suitesparse-amd/usr/lib/libamd.so.2.4.6 [rpaths]
# do_install:append() {
#     rm -rf ${D}${libdir}/*${SOLIBS}
# }
EXTRA_OECMAKE += "\
    -DCMAKE_SKIP_RPATH=ON \
"