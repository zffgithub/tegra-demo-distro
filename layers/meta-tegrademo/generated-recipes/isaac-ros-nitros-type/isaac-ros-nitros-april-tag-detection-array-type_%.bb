
# Generated by superflore -- DO NOT EDIT
#
# Copyright Open Source Robotics Foundation

inherit ros_distro_humble
inherit ros_superflore_generated

DESCRIPTION = "Isaac ROS Nitros Apriltag Detection Array Type"
AUTHOR = "Hemal Shah <hemals@nvidia.com>"
ROS_AUTHOR = "Ashwin Varghese Kuruttukulam,CY Chen,Swapnesh Wani"
HOMEPAGE = "https://developer.nvidia.com/isaac-ros-gems/"
SECTION = "devel"
# Original license in package.xml, joined with "&" when multiple license tags were used:
#         "Apache License 2.0"
LICENSE = "NVIDIA Isaac ROS Software License"
LIC_FILES_CHKSUM = "file://package.xml;beginline=20;endline=20;md5=12c26a18c7f493fdc7e8a93b16b7c04f"

ROS_CN = "isaac_ros_nitros_april_tag_detection_array_type"
ROS_BPN = "isaac_ros_nitros_april_tag_detection_array_type"

ROS_BUILD_DEPENDS = " \
    isaac-ros-common
"

ROS_BUILDTOOL_DEPENDS = " \
    ament-cmake-native
"

ROS_EXPORT_DEPENDS = " \
    rclcpp \
	rclcpp-components \
	isaac-ros-apriltag-interfaces \
	isaac-ros-nitros
"

ROS_BUILDTOOL_EXPORT_DEPENDS = " \
    
"

ROS_EXEC_DEPENDS = " \
    rclcpp \
	rclcpp-components \
	isaac-ros-apriltag-interfaces \
	isaac-ros-nitros
"

# Currently informational only -- see http://www.ros.org/reps/rep-0149.html#dependency-tags.
ROS_TEST_DEPENDS = " \
    ament-lint-auto \
	ament-lint-common \
	isaac-ros-test
"

DEPENDS = "${ROS_BUILD_DEPENDS} ${ROS_BUILDTOOL_DEPENDS}"
# Bitbake doesn't support the "export" concept, so build them as if we needed them to build this package (even though we actually
# don't) so that they're guaranteed to have been staged should this package appear in another's DEPENDS.
DEPENDS += "${ROS_EXPORT_DEPENDS} ${ROS_BUILDTOOL_EXPORT_DEPENDS}"

RDEPENDS:${PN} += "${ROS_EXEC_DEPENDS}"

# matches with: https://github.com/ros2-gbp/ament_cmake-release/archive/release/humble/ament_cmake/1.3.1-2.tar.gz
ROS_BRANCH ?= "branch=main"
SRC_URI = "git://github.com/zff-ros/isaac_ros_nitros_april_tag_detection_array_type;${ROS_BRANCH};protocol=https"
SRCREV = "b7c43d7da303e96c296aca6bc525b9974ce9a53d"
S = "${WORKDIR}/git"

ROS_BUILD_TYPE = "ament_cmake"

inherit ros_${ROS_BUILD_TYPE}
    