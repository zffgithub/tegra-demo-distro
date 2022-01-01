SUMMARY = "The custom image just capable of starting core ROS."
DESCRIPTION = "${SUMMARY}"

# ROS_SUPERFLORE_GENERATED_ARCH_SPECIFIC_* variables are MACHINE specific
PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup
inherit ros_distro_${ROS_DISTRO}
# inherit ${ROS_DISTRO_TYPE}_image
# inherit ros_superflore_generated

# LICENSE = "Apache-2.0"
# LIC_FILES_CHKSUM = "file://package.xml;beginline=8;endline=8;md5=12c26a18c7f493fdc7e8a93b16b7c04f"

LICENSE="CLOSED"
LIC_FILES_CHKSUM=""
BB_STRICT_CHECKSUM = "0"
PACKAGES = "${PN}"

# ROS_CN = "variants"
# ROS_BPN = "ros_custom"

# ROS_BUILD_DEPENDS = ""

# ROS_BUILDTOOL_DEPENDS = " \
#    ament-cmake-native \
# "

# ROS_EXPORT_DEPENDS = ""

# ROS_BUILDTOOL_EXPORT_DEPENDS = ""

ROS_EXEC_DEPENDS = " \
    action-msgs \
    ament-cmake \
    ament-cmake-auto \
    ament-cmake-gmock \
    ament-cmake-gtest \
    ament-cmake-pytest \
    ament-cmake-ros \
    ament-index-cpp \
    ament-index-python \
    ament-lint-auto \
    ament-lint-common \
    ament-package \
    builtin-interfaces \
    class-loader \
    common-interfaces \
    composition-interfaces \
    console-bridge-vendor \
    cyclonedds \
    eigen3-cmake-module \
    geometry2 \
    google-benchmark-vendor \
    gmock-vendor \
    gtest-vendor \
    fastcdr \
    fastrtps \
    fastrtps-cmake-module \
    foonathan-memory-vendor \
    iceoryx-binding-c \
    iceoryx-posh \
    iceoryx-utils \
    kdl-parser \
    launch \
    launch-ros \
    launch-testing \
    launch-testing-ament-cmake \
    launch-testing-ros \
    launch-xml \
    launch-yaml \
    libstatistics-collector \
    libyaml-vendor \
    lifecycle-msgs \
    message-filters \
    mimick-vendor \
    orocos-kdl \
    osrf-pycommon \
    osrf-testing-tools-cpp \
    performance-test-fixture \
    pluginlib \
    pybind11-vendor \
    python-cmake-module \
    rcl \
    rcl-action \
    rcl-interfaces \
    rcl-lifecycle \
    rcl-logging-interface \
    rcl-logging-log4cxx \
    rcl-logging-noop \
    rcl-logging-spdlog \
    rcl-yaml-param-parser \
    rclcpp \
    rclcpp-action \
    rclcpp-components \
    rclcpp-lifecycle \
    rcpputils \
    rclpy \
    rcutils \
    rmw \
    rmw-cyclonedds-cpp \
    rmw-dds-common \
    rmw-fastrtps-cpp \
    rmw-fastrtps-dynamic-cpp \
    rmw-fastrtps-shared-cpp \
    rmw-implementation \
    rmw-implementation-cmake \
    robot-state-publisher \
    ros-environment \
    ros-testing \
    rosbag2 \
    rosbag2-transport \
    rosbag2-tests \
    rosbag2-test-common \
    rosbag2-storage \
    rosbag2-storage-default-plugins \
    rosbag2-py \
    rosbag2-performance-benchmarking \
    rosbag2-interfaces \
    rosbag2-cpp \
    rosbag2-compression \
    rosbag2-compression-zstd \
    ros2bag \
    ros2action \
    ros2cli-test-interfaces \
    ros2cli \
    ros2component \
    ros2doctor \
    ros2interface \
    ros2lifecycle-test-fixtures \
    ros2lifecycle \
    ros2multicast \
    ros2node \
    ros2param \
    ros2pkg \
    ros2run \
    ros2service \
    ros2topic \
    ros2cli-common-extensions \
    ros2launch \
    ros2test \
    ros2trace \
    rttest \
    tracetools-launch \
    tracetools-read \
    tracetools-test \
    tracetools-trace \
    tracetools \
    rosgraph-msgs \
    rosidl-default-generators \
    rosidl-default-runtime \
    shared-queues-vendor \
    statistics-msgs \
    sqlite3-vendor \
    test-msgs \
    tlsf-cpp \
    pluginlib \
    rosidl-adapter \
    rosidl-generator-py \
    rosidl-cli \
    rosidl-cmake \
    rosidl-default-generators \
    rosidl-default-runtime \
    rosidl-generator-c \
    rosidl-generator-cpp \
    rosidl-parser \
    rosidl-runtime-c \
    rosidl-runtime-cpp \
    rosidl-runtime-py \
    rosidl-typesupport-c \
    rosidl-typesupport-cpp \
    rosidl-typesupport-fastrtps-c \
    rosidl-typesupport-fastrtps-cpp \
    rosidl-typesupport-interface \
    rosidl-typesupport-introspection-c \
    rosidl-typesupport-introspection-cpp \
    rosidl-generator-dds-idl \
    rpyutils \
    sros2 \
    sros2-cmake \
    spdlog-vendor \
    test-interface-files \
    tinyxml-vendor \
    tinyxml2-vendor \
    tlsf \
    uncrustify-vendor \
    unique-identifier-msgs \
    urdf-parser-plugin \
    urdf \
    urdfdom \
    urdfdom-headers \
    yaml-cpp-vendor \
    zstd-vendor \
"

# Currently informational only -- see http://www.ros.org/reps/rep-0149.html#dependency-tags.
# ROS_TEST_DEPENDS = ""

# DEPENDS = "${ROS_BUILD_DEPENDS} ${ROS_BUILDTOOL_DEPENDS}"
# Bitbake doesn't support the "export" concept, so build them as if we needed them to build this package (even though we actually
# don't) so that they're guaranteed to have been staged should this package appear in another's DEPENDS.
# DEPENDS += "${ROS_EXPORT_DEPENDS} ${ROS_BUILDTOOL_EXPORT_DEPENDS}"

RDEPENDS:${PN} += "${ROS_EXEC_DEPENDS}"

# matches with: https://github.com/ros2-gbp/variants-release/archive/release/galactic/ros_core/0.9.3-2.tar.gz
# ROS_BRANCH ?= "branch=release/galactic/ros_core"
# SRC_URI = "git://github.com/ros2-gbp/variants-release;${ROS_BRANCH};protocol=https"
# SRCREV = "bc7c49cef699a7880add337679d5f2a781e046ab"
# S = "${WORKDIR}/git"

# ROS_BUILD_TYPE = "ament_cmake"

# inherit ros_${ROS_BUILD_TYPE}


# IMAGE_INSTALL:append = " \
#     ros-core \
# "
