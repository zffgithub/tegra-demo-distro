FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
SRC_URI += "\
    file://libcudacxx_aarch64_cuda_11_4.diff \
"

do_compile:append(){
    patch -N -i ${WORKDIR}/libcudacxx_aarch64_cuda_11_4.diff ${D}/usr/local/cuda-11.4/include/cuda/std/detail/libcxx/include/cmath
}