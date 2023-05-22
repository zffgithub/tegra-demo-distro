ROS_BUILDTOOL_DEPENDS += " \
    ament-cmake-auto-native \
    rosidl-adapter-native \
    rosidl-default-generators-native \
"

ROS_BUILD_DEPENDS += " \
    action-msgs \
"


inherit fix-ros

# FILES:${PN} += " \
#     /usr/lib/libisaac_ros_nitros.so \
# "