#!/usr/bin/env bash
set -euo pipefail
cd /root/autodl-tmp/gaussian-splatting
git submodule update --init --depth 1 --recursive submodules/diff-gaussian-rasterization submodules/simple-knn
export CUDA_HOME=/usr/local/cuda-11.8
export PATH="$CUDA_HOME/bin:$PATH"
export TORCH_CUDA_ARCH_LIST=8.9
export MAX_JOBS=8
cd submodules/diff-gaussian-rasterization
/root/miniconda3/bin/python setup.py build_ext --inplace
cd ../simple-knn
/root/miniconda3/bin/python setup.py build_ext --inplace
echo BUILD_OK