"""
    图形界面
"""

import tkinter as GUI  # 使用Tkinter_GUI包

window = GUI.Tk()  # 实例化object，建立窗口window
window.title('My Window')  # 窗口名
window.geometry('800x800')  # 设定窗口的大小(长x宽)

# 在界面上设定标签
mylabel = GUI.Label(window, text='你好！this is Tkinter', bg='green', font=('Arial', 12), width=30, height=2)
# 说明： bg为背景，font为字体，width为长，height为高，这里的长和高是字符的长和高，比如height=2,就是标签有2个字符这么高

# 放置标签
mylabel.pack()  # Label内容content区域放置位置，自动调节尺寸
# 放置lable的方法有：1）mylabel.pack(); 2)mylabel.place();

# 主窗口循环显示
window.mainloop()
# 注意，loop因为是循环的意思，window.mainloop就会让window不断的刷新
# 如果没有mainloop,就是一个静态的window,传入进去的值就不会有循环，
# mainloop就相当于一个很大的while循环，有个while，每点击一次就会更新一次，所以我们必须要有循环
# 所有的窗口文件都必须有类似的mainloop函数，mainloop是窗口文件的关键的关键。
