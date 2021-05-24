"""
    用到的功能函数
"""


# 根据输入文件路径 得到输出文件路径
def getOutputFile(infile):
    # 分割input后缀(从右侧分割’.')
    outfile = infile.rsplit('.', 1)[0] + '_out.' + infile.rsplit('.', 1)[1]
    return outfile
