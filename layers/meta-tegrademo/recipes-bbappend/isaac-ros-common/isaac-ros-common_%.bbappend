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

VPI_PREFIX = "/opt/nvidia/vpi2"
FILES:${PN} += "${VPI_PREFIX}"
EXTRA_OECMAKE += "-Dvpi_DIR=${STAGING_DIR_HOST}${VPI_PREFIX}/lib/aarch64-linux-gnu/cmake/vpi"

# do_install:append() {
#     install -m 0755 -d ${D}${libdir}/vpi2 
#     install -m 0755 ${S}/opt/nvidia/vpi2 ${D}${libdir}/vpi2
# }