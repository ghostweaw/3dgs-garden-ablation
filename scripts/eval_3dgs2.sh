#!/usr/bin/env bash
set -euo pipefail
source /root/miniconda3/etc/profile.d/conda.sh
conda activate base
export CUDA_HOME=/usr/local/cuda-11.8
export PATH="$CUDA_HOME/bin:$PATH"
export PYTHONPATH=/root/autodl-tmp/gaussian-splatting:/root/autodl-tmp/gaussian-splatting/submodules/diff-gaussian-rasterization:/root/autodl-tmp/gaussian-splatting/submodules/simple-knn
cd /root/autodl-tmp/gaussian-splatting
for v in full no_densification no_sh no_antialiasing; do
  echo "=== render $v $(date) ==="
  /root/miniconda3/bin/python render.py -m "/root/autodl-tmp/results/$v" --skip_train
  echo "=== metrics $v $(date) ==="
  /root/miniconda3/bin/python metrics_alex.py -m "/root/autodl-tmp/results/$v"
done
echo EVAL_DONE