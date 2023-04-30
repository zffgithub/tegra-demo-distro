DESCRIPTION = "Packagegroup for Isaac"

LICENSE = "MIT"

inherit packagegroup

RDEPENDS:${PN} += " \
    ros-base \
    tlsf-cpp \
    ros2-control \
    image-common \
    image-pipeline \
    image-transport-plugins \
    vision-opencv \
    perception-pcl \
    isaac-ros-argus-camera \
"