"""
    图形界面 回调函数
"""
import attribute as at
import tkinter as tk  # 使用Tkinter_GUI包
from tkinter import filedialog


# 选择文件按钮
def func_chooseFile():
    # 打开文件选择对话框 返回选择文件路径
    filename = tk.filedialog.askopenfilename()
    if filename:
        print("选择文件:", filename)
        at.file_input = filename
    else:
        print("未找到该文件")
