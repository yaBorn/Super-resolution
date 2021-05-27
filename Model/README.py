"""
    README 模型说明
        SRCNN
        分辨率不变，细节重建
            91xN：使用91 images，缩小 1/N 分辨率，后 bicubic 插值到原分辨率作为LR(低分辨率)训练数据
            INxN：使用ImageNet

        FSRCNN
        xN -> 放大N倍分辨率，并重建细节
            xN：缩小1/N分辨率，bicubic插值到原分辨率作为LR训练数据，conv2卷积层 进行9次映射层卷积
            -s_xN：轻量化网络模型，进行3次映射层卷积，170*170 -> 510*510 放大能做到实时

        EDVR

    TODO
        -> .md
"""
