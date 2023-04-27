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
"

RDEPENDS:${PN} += " \
    isaac-ros-argus-camera \
"

ROS_SUPERFLORE_GENERATED_RECIPES += " \
    isaac-ros-argus-camera \
"

ROS_SUPERFLORE_GENERATED_RECIPE_BASENAMES_WITH_COMPONENT += " \
    isaac-ros-argus-camera/isaac-ros-argus-camera_% \
" 

ROS_SUPERFLORE_GENERATED_WORLD_PACKAGES += " \
    isaac-ros-argus-camera \
" 

ROS_SUPERFLORE_GENERATED_RECIPES_FOR_COMPONENTS += " \
    isaac-ros-argus-camera \
" 
