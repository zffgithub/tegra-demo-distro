ROS_BUILDTOOL_DEPENDS += " \
    ament-cmake-auto-native \
"

SRCREV = "5fdbfe3b94c41f7521c3bbe037db51c22b2d886e"

EXTRA_OECMAKE += "-DARCHITECTURE=aarch64"

do_package_qa[noexec] = "1"