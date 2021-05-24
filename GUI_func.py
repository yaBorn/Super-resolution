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
is_VideoImage = 1  # 1为图像超分

# 超分算法
#   图像超分辨率算法：
#   视频超分辨率算法：

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
def func_VideoImage(ch):
    global is_VideoImage
    is_VideoImage = ch
    if is_VideoImage:
        print("选择图像超分 is_VideoImage:" + str(is_VideoImage))
    else:
        print("选择视频超分 is_VideoImage:" + str(is_VideoImage))
