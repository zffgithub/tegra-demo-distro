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
"

SRCREV = "adaf50627ed0fcaaf433a6bff0e8047af24fcbd4"

# EXTRA_OECMAKE += "-DCMAKE_MODULE_PATH:PATH=${STAGING_DIR_HOST}/usr/share/isaac_ros_gxf/cmake/modules;${STAGING_DIR_HOST}/usr/lib/cmake/yaml-cpp"

VPI_PREFIX = "/opt/nvidia/vpi2"
FILES:${PN} += "${VPI_PREFIX}"
EXTRA_OECMAKE += "-Dvpi_DIR=${STAGING_DIR_HOST}${VPI_PREFIX}/lib/aarch64-linux-gnu/cmake/vpi"

# EXTRA_OECMAKE += "-DGXF_DIR=${STAGING_DIR_HOST}/usr/share/isaac_ros_gxf/cmake/modules"

EXTRA_OECMAKE += "-DCMAKE_MODULE_PATH:PATH=${STAGING_DIR_HOST}/usr/share/isaac_ros_gxf/cmake/modules"
# EXTRA_OECMAKE += "-DYamlCpp_DIR=${STAGING_DIR_HOST}/usr/lib/cmake/yaml-cpp"
