set -ex

apt-get update  -y \
    && apt-get install -y git wget vim numactl gcc-12 g++-12 python3 python3-pip libtcmalloc-minimal4 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 10 --slave /usr/bin/g++ g++ /usr/bin/g++-12

echo 'export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libtcmalloc_minimal.so.4:$LD_PRELOAD' >> ~/.bashrc

poetry install
poetry run pip install -v -r source/requirements-cpu.txt --extra-index-url https://download.pytorch.org/whl/cpu
VLLM_TARGET_DEVICE=cpu poetry run python source/setup.py sdist bdist_wheel
