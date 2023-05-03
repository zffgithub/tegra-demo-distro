FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
SRC_URI += "\
    file://libcudacxx_aarch64_cuda_11_4.diff \
"

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