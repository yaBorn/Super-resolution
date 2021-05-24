"""
    图形界面 回调函数
"""
import attribute as at
import tkinter as tk  # 使用Tkinter_GUI包
from tkinter import filedialog, END


# 选择文件按钮
def func_chooseFile(entry):
    # 打开文件选择对话框 返回选择文件路径
    filename = tk.filedialog.askopenfilename()
    if filename:
        print("选择文件:", filename)
        at.file_input = filename
        # 设置文本框内容
        entry.config(state='normal')  # 写入后设为只读
        entry.delete(0, END)  # 删除entry框内容
        entry.insert(0, filename)  # entry显示当前路径
        entry.config(state='readonly')  # 写入后设为只读
    else:
        print("未找到该文件")


