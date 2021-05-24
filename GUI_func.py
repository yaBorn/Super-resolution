"""
    图形界面 回调函数
"""
import attribute as at
import Base_func as bf
import tkinter as tk  # 使用Tkinter_GUI包
from tkinter import filedialog, END


# 选择文件按钮
def func_chooseFile(entryInput, entryOutput):
    # 打开文件选择对话框 返回选择文件路径
    filename = tk.filedialog.askopenfilename()
    if filename:
        # 分割字符串 处理为
        at.file_input = filename
        at.file_output = bf.getOutputFile(filename)
        print("输入文件:", at.file_input)
        print("预输出文件:", at.file_output)
        # 设置文本框内容
        entryInput.config(state='normal')  # 写入后设为只读
        entryInput.delete(0, END)  # 删除entry框内容
        entryInput.insert(0, at.file_input)  # entry显示当前路径
        entryInput.config(state='readonly')  # 写入后设为只读

        entryOutput.config(state='normal')
        entryOutput.delete(0, END)
        entryOutput.insert(0, at.file_output)
        entryOutput.config(state='readonly')
    else:
        print("未找到该文件")


