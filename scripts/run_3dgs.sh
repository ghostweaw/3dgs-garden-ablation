#!/usr/bin/env bash
set -euo pipefail
source /root/miniconda3/etc/profile.d/conda.sh
conda activate base
export CUDA_HOME=/usr/local/cuda-11.8
export PATH="$CUDA_HOME/bin:$PATH"
export PYTHONPATH=/root/autodl-tmp/gaussian-splatting:/root/autodl-tmp/gaussian-splatting/submodules/diff-gaussian-rasterization:/root/autodl-tmp/gaussian-splatting/submodules/simple-knn
cd /root/autodl-tmp/gaussian-splatting
DATA=/root/autodl-tmp/data/garden
OUT=/root/autodl-tmp/results
mkdir -p "$OUT"
run_variant() {
  name="$1"; shift
  echo "=== $name start $(date) ==="
  /root/miniconda3/bin/python train.py -s "$DATA" -m "$OUT/$name" -r 1 --iterations 30000 --test_iterations 30000 --save_iterations 30000 --checkpoint_iterations 30000 --eval --disable_viewer "$@"
  echo "=== $name done $(date) ==="
}
run_variant full --antialiasing
run_variant no_densification --antialiasing --densify_until_iter 0
run_variant no_sh --antialiasing --sh_degree 0
run_variant no_antialiasing
echo ALL_DONE