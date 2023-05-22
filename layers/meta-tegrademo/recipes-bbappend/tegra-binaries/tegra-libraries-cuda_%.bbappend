do_compile:append(){
    patch -t -i ${COREBASE}/meta-tegrademo/files/libcudacxx_aarch64_cuda_11_4.diff ${B}/usr/local/cuda-${CUDA_VERSION}/include/cuda/std/detail/libcxx/include/cmath
}