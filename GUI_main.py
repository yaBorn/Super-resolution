"""
    图形界面
"""

import tkinter as tk  # 使用Tkinter_GUI包
from GUI_func import *  # 按键回调函数

window = tk.Tk()  # 实例化object，建立窗口window
window.title('Super-resolution')  # 窗口名
window.geometry('800x800')  # 设定窗口的大小(长x宽)

''' 标签 '''
title = tk.Label(window, text='你好！this is title', bg='green', font=('Arial', 12), width=30, height=2)
# 说明： bg为背景，font为字体，width为长，height为高，这里的是字符的长和高
title.pack()

''' 选择文件按钮'''
chooseFile = tk.Button(window, text='选择文件', font=('Arial', 12), width=10, height=1, command=func_chooseFile)
# command是按钮回调函数
chooseFile.pack()

# 主窗口循环显示
window.mainloop()
# 注意，loop因为是循环的意思，window.mainloop就会让window不断的刷新
# 如果没有mainloop,就是一个静态的window,传入进去的值就不会有循环，
# mainloop就相当于一个很大的while循环，有个while，每点击一次就会更新一次，所以我们必须要有循环
# 所有的窗口文件都必须有类似的mainloop函数，mainloop是窗口文件的关键的关键。
