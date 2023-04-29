inherit cuda

ROS_BUILDTOOL_DEPENDS += " \
    rosidl-adapter-native \
"

ROS_BUILD_DEPENDS += " \
    rosidl-runtime-c \
    rosidl-typesupport-introspection-cpp-native \
    rosidl-typesupport-fastrtps-cpp \
    rosidl-typesupport-fastrtps-c \
    rosidl-typesupport-cpp \
    rosidl-typesupport-c \  
    libnvvpi2 \ 
"