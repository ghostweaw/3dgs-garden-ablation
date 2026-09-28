# 官方 3DGS garden 消融实验总结

## 实验设置

- GPU：RTX 4090D 24GB
- 数据：官方 Mip-NeRF 360 garden images_8，648x420
- 训练图：161 张，测试图：24 张
- 初始点：138,766 个 COLMAP 稀疏点
- 每组训练：30,000 步
- CUDA 11.8 + PyTorch 2.1.2+cu118
- 官方 CUDA rasterizer，目标架构 sm_89
- LPIPS 使用 AlexNet 版本（VGG16 权重下载过慢）

## 结果

| 模型 | PSNR | SSIM | LPIPS-Alex |
|---|---:|---:|---:|
| 完整模型 + 抗锯齿 | 28.766 | 0.9069 | 0.0383 |
| 去掉 adaptive densification | 27.219 | 0.8512 | 0.1033 |
| 球谐阶数设为 0 | 28.262 | 0.8982 | 0.0444 |
| 去掉抗锯齿 | 29.350 | 0.9212 | 0.0291 |

## 结论

1. 去掉 adaptive densification 影响最大，PSNR 下降约 1.55 dB，LPIPS 明显变差。
2. 去掉球谐颜色有小幅下降，说明视角相关颜色对该场景有一定作用。
3. 本次 30k 步设置下，经典 rasterizer 的 SSIM/LPIPS 略好，但差距很小。
4. 这是单场景小型消融，不是完整论文复现。
