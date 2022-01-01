DESCRIPTION = "Full Tegra demo image with X11/Sato, nvidia-docker, OpenCV, \
VPI samples, TensorRT samples, and Tegra multimedia API sample apps."

require demo-image-common.inc

IMAGE_FEATURES += "splash hwcodecs"

# inherit features_check

# rm x11 opengl
REQUIRED_DISTRO_FEATURES = "virtualization"

# CORE_IMAGE_BASE_INSTALL += "packagegroup-demo-x11tests"
# CORE_IMAGE_BASE_INSTALL += "${@bb.utils.contains('DISTRO_FEATURES', 'vulkan', 'packagegroup-demo-vulkantests', '', d)}"
# rm tegra-mmapi-tests vpi1-tests tensorrt-tests
CORE_IMAGE_BASE_INSTALL += "nvidia-docker cuda-libraries libvisionworks-devso-symlink"
