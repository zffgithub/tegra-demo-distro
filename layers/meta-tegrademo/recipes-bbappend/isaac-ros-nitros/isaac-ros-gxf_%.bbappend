ROS_BUILDTOOL_DEPENDS += " \
    ament-cmake-auto-native \
"

SRCREV = "f3b8e218d375afd0548062c90751a2828d0a7d86"

EXTRA_OECMAKE += "-DARCHITECTURE=aarch64"

do_package_qa[noexec] = "1"

# SRC_URI = "git://github.com/zff-ros/isaac_ros_gxf;${ROS_BRANCH};protocol=https;lfs=1"