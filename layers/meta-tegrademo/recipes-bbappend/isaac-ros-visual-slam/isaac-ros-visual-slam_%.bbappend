ROS_BUILDTOOL_DEPENDS += " \
    ament-cmake-auto-native \
    rosidl-adapter-native \
    rosidl-default-generators-native \
"

ROS_BUILD_DEPENDS += " \
    action-msgs \
"

EXTRA_OECMAKE += "-DARCHITECTURE=aarch64"
SRCREV = "2390bc069d48a5e89feb23e232dc23392a75899b"

inherit fix-ros

FILES:${PN} += " \
    /usr/share/elbrus/libelbrus.so \
"

ALTERNATIVE_LINK_NAME[elbrus] = "${datadir}/elbrus"