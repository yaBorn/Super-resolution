import Base_func as base
import tkinter as tk  # 使用Tkinter_GUI包
from tkinter import filedialog, END

"""
    程序属性配置
"""

# 输入文件路径
file_input = ''
# 输出文件路径
file_output = ''

# 视频/图像 超分
is_VideoImage = 'image'  # 默认为图像超分

# 超分算法
#   图像超分辨率算法：SRCNN FSRCNN
#   视频超分辨率算法：
use_ways = 'SRCNN'

# 使用训练模型

"""
    图形界面 回调函数
"""


# 选择文件 按钮
def func_chooseFile(entryInput, entryOutput):
    # 打开文件选择对话框 返回选择文件路径
    filename = tk.filedialog.askopenfilename()
    if filename:
        # 分割字符串 处理文件路径
        global file_input, file_output
        file_input = filename
        file_output = base.getOutputFile(filename)
        print("输入文件:", file_input)
        print("预输出文件:", file_output)

        # 设置输入输出文本框内容
        entryInput.config(state='normal')  # 写入后设为只读
        entryInput.delete(0, END)  # 删除entry框内容
        entryInput.insert(0, file_input)  # entry显示当前路径
        entryInput.config(state='readonly')  # 写入后设为只读
        entryOutput.config(state='normal')
        entryOutput.delete(0, END)
        entryOutput.insert(0, file_output)
        entryOutput.config(state='readonly')
    else:
        print("未找到该文件")


# 图像/视频 选项
def func_VideoImage(ch, radio1, radio2):
    global use_ways, is_VideoImage
    if ch == 'image':  # 图像
        is_VideoImage = ch
        # 设定算法选项
        use_ways = 'SRCNN'  # 参数更改
        radio1.config(text='SRCNN', value='SRCNN', command=lambda: func_Ways(ch='SRCNN'))
        radio2.config(text='FSRCNN', value='FSRCNN', command=lambda: func_Ways(ch='FSRCNN'))
        print("选择图像超分 is_VideoImage:" + str(is_VideoImage) + " use_ways:" + str(use_ways))

    elif ch == 'video':  # 视频
        is_VideoImage = ch
        # 设定算法选项
        use_ways = 'EDVR'
        radio1.config(text='EDVR', value='EDVR', command=lambda: func_Ways(ch='EDVR'))
        radio2.config(text='    ', value='EDVR', command=lambda: func_Ways(ch='EDVR'))
        print("选择视频超分 is_VideoImage:" + str(is_VideoImage) + " use_ways:" + str(use_ways))

    else:
        print("error：图像/视频选项 ch:" + str(ch))


# 算法 选项
def func_Ways(ch):
    global use_ways, is_VideoImage
    use_ways = ch
    if is_VideoImage == 'image':  # 图像算法
        print("图像超分 use_ways:" + str(use_ways))
    elif is_VideoImage == 'video':  # 视频算法
        print("视频超分 use_ways:" + str(use_ways))
    else:
        print("error：算法选项 is_VideoImage:" + str(is_VideoImage) + " use_ways:" + str(use_ways))


# 模型 选项
def func_chModel():
    if is_VideoImage == 'image':  # 图像算法
        if use_ways == 'SRCNN':
            print("图像超分 " + str(use_ways))
        elif use_ways == 'FSRCNN':
            print("图像超分 " + str(use_ways))
        else:
            print("error：图像超分 " + str(use_ways))
    elif is_VideoImage == 'video':  # 视频算法
        print("视频超分 use_ways:" + str(use_ways))
    else:
        print("error：模型选项 is_VideoImage:" + str(is_VideoImage) + " use_ways:" + str(use_ways))
