ROS_BUILDTOOL_DEPENDS += " \
    ament-cmake-auto-native \
    rosidl-adapter-native \
    rosidl-default-generators-native \
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

# FILES:${PN} += " \
#     /usr/lib/libisaac_ros_nitros.so \
# "