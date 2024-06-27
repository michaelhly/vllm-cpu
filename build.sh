set -ex

apt-get update  -y \
    && apt-get install -y git wget vim numactl gcc-12 g++-12 python3 python3-pip libtcmalloc-minimal4 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 10 --slave /usr/bin/g++ g++ /usr/bin/g++-12

pip install --upgrade pip \
    && pip install wheel packaging ninja "setuptools>=49.4.0" numpy
pip install -v -r requirements-cpu.txt --extra-index-url https://download.pytorch.org/whl/cpu

# Support for building with non-AVX512 vLLM: docker build --build-arg VLLM_CPU_DISABLE_AVX512="true" ...
VLLM_CPU_DISABLE_AVX512="true" VLLM_TARGET_DEVICE=cpu \
    python3 setup.py bdist_wheel --dist-dir=dist
