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


EXTRA_OECMAKE += "-DCMAKE_MODULE_PATH:PATH=${STAGING_DIR_HOST}/usr/share/isaac_ros_gxf/cmake/modules;${STAGING_DIR_HOST}/usr/lib/cmake/yaml-cpp"

VPI_PREFIX = "/opt/nvidia/vpi2"
EXTRA_OECMAKE += "-DCMAKE_INSTALL_PREFIX:PATH=${VPI_PREFIX}"
FILES:${PN} += "${VPI_PREFIX}"