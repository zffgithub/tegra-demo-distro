inherit cuda

# https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_nitros/issues/19
# FILESEXTRAPATHS:prepend := "${COREBASE}/meta-tegrademo/files:"
# SRC_URI += "\
#     file://libcudacxx_aarch64_cuda_11_4.diff \
# "
do_compile:prepend(){
    patch -t -i ${COREBASE}/meta-tegrademo/files/libcudacxx_aarch64_cuda_11_4.diff ${STAGING_DIR_HOST}/usr/local/cuda-11.4/include/cuda/std/detail/libcxx/include/cmath
}


ROS_BUILDTOOL_DEPENDS += " \
    ament-cmake-auto-native \
"

do_configure:prepend() {
    find ${S} -name CMakeLists.txt | xargs \
    sed -e "s#include(YamlCpp)#find_package(yaml-cpp REQUIRED)#g" \
        -e 's#link_libraries("nvToolsExt")#include_directories("${STAGING_DIR_HOST}/usr/local/cuda-11.4/include")\n    include_directories("${STAGING_DIR_HOST}/usr/local/cuda-11.4/include/nvtx3")\n    link_directories("${STAGING_DIR_HOST}/usr/local/cuda-11.4/lib/")#g' \
        -i # ${S}/CMakeLists.txt
}

# GXF
EXTRA_OECMAKE += "-DCMAKE_MODULE_PATH:PATH=${STAGING_DIR_HOST}/usr/share/isaac_ros_gxf/cmake/modules"
EXTRA_OECMAKE += "-Disaac_ros_gxf_DIR=${STAGING_DIR_HOST}/usr/share/isaac_ros_gxf/cmake"

# NVTX
EXTRA_OECMAKE += "-DCUDA_TOOLKIT_ROOT_DIR=${STAGING_DIR_HOST}/usr/local/cuda-11.4"
EXTRA_OECMAKE += "-DSTAGING_DIR_HOST=${STAGING_DIR_HOST}"

# do_package_qa: QA Issue: non -staticdev package contains static .a library: isaac-ros-nitros path '/usr/share/isaac_ros_nitros/nvapriltags/lib_x86_64_cuda_11_8/libapril_tagging.a'
INSANE_SKIP:${PN} += "staticdev"


# For some reason ends with bad RPATH
# WARNING: do_package_qa: QA Issue: package suitesparse-amd contains bad RPATH /jenkins/mjansa/build-ros/ros2-dashing-master/tmp-glibc/work/core2-32-oe-linux/suitesparse-amd/2.4.6-r0/image/usr/lib in file /jenkins/mjansa/build-ros/ros2-dashing-master/tmp-glibc/work/core2-32-oe-linux/suitesparse-amd/2.4.6-r0/packages-split/suitesparse-amd/usr/lib/libamd.so.2.4.6 [rpaths]
EXTRA_OECMAKE += "\
    -DCMAKE_SKIP_RPATH=ON \
"

# vpi2
VPI_PREFIX = "/opt/nvidia/vpi2"
FILES:${PN} += "${VPI_PREFIX}"
EXTRA_OECMAKE += "-Dvpi_DIR=${STAGING_DIR_HOST}${VPI_PREFIX}/lib/aarch64-linux-gnu/cmake/vpi"