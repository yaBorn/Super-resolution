"""
    图形界面
"""
import tkinter as tk  # 使用Tkinter_GUI包
from tkinter import StringVar
import GUI_func as gui


""" 窗口初始化 """
window = tk.Tk()  # 实例化object，建立窗口window
window.title('Super-resolution 超分辨率工具箱 v1.0_demo')  # 窗口名
window.geometry('740x690')  # 设定窗口的大小(长x宽)
window.resizable(0, 0)  # 设置窗口大小不可变
myfront = ['Consolas', 11]  # 字体参数

""" 框架组件 用于布局"""
# 父组件 边框像素(1凹陷感，2框线感)->简写bd 边线风格 垂直边距 高 宽
f1 = tk.Frame(window, borderwidth=2, relief="groove", height=100, width=700)
f2 = tk.Frame(window, borderwidth=2, relief="groove", height=110, width=700)
f3 = tk.Frame(window, borderwidth=2, relief="groove", height=400, width=700)
# grid布局 所在行 所在列 (跨越行数) 水平边距 垂直边距
f1.grid(row=0, column=0, padx=20, pady=20)  # 700+20+20=740 边框长+边距*2=窗口长 因此边框居中
f2.grid(row=1, column=0, padx=20, pady=0)
f3.grid(row=2, column=0, padx=20, pady=20)
# 固定组件大小,防止子组件大小影响
f1.grid_propagate(0)
f2.grid_propagate(0)
f3.grid_propagate(0)


""" 标签 输入输出"""
title_output = tk.Label(f1, text='输出路径：', font=myfront, width=0, height=0)
title_input = tk.Label(f1, text='输入路径：', font=myfront, width=0, height=0)
# font为字体 width为长 height为高 这里的是字符的长和高(字符间距)
""" 输入路径 """
text_input = tk.Entry(f1, width=65, bd=2, show=None, state='normal')  # 无密文 可写
text_input.insert(0, "未选择...")  # 写入文本
text_input.config(state='readonly')  # 写入后设为只读
""" 输出路径 """
text_output = tk.Entry(f1, width=65, bd=2, show=None, state='normal')
text_output.insert(0, "未选择...")
text_output.config(state='readonly')
""" 按钮 选择文件 """
button_chooseFile = tk.Button(f1, text='选择文件', font=myfront, width=10, height=1, bd=4,
                              command=lambda: gui.func_chooseFile(entryInput=text_input, entryOutput=text_output))
# command是按钮回调函数 lambda:传递参数
""" 按钮 开始 """
button_start = tk.Button(f1, text='开始', font=myfront, width=10, height=1, bd=4,
                         command=lambda: gui.func_start())
""" 布局 """
title_input.grid(row=0, column=0, padx=10, pady=15)
title_output.grid(row=1, column=0, padx=10, pady=0)
text_input.grid(row=0, column=1, padx=0, pady=0)
text_output.grid(row=1, column=1, padx=0, pady=0)
button_chooseFile.grid(row=0, column=2, padx=15, pady=0)
button_start.grid(row=1, column=2, padx=15, pady=0)


""" 标签 参数选择"""
title_chvi = tk.Label(f2, text='视频/图像：', font=myfront, width=0, height=0)
title_chways = tk.Label(f2, text='选择算法：', font=myfront, width=0, height=0)
title_model = tk.Label(f2, text='训练模型：', font=myfront, width=0, height=0)
""" 列表 模型选择 """
fl = tk.Frame(f2, borderwidth=2, relief="groove", height=100, width=160)  # 滚动条和显示框 组合框 用于布局
scroll_model = tk.Scrollbar(fl, orient='vertical')  # 用于list的垂直滚动条
list_model = tk.Listbox(fl, height=5, yscrollcommand=scroll_model.set)  # 创建list组件 height指定显示行数 yscrollcommand设置滚动条
list_model.bind('<<ListboxSelect>>', lambda event: gui.func_chModel(listbox=list_model))  # 列表框绑定函数 参数传递
gui.renewList(list_model, gui.model_srcnn)  # 更新list
scroll_model.config(command=list_model.yview)  # 操作滚动条 调用list显示
""" 单选 算法选择 """
# 创建n个radiobutton 其中variable=var
# value='A'：当选中其中一个选项 将value赋值到variable的参数 variable的参数变量控制绘制的显示状态
r_way = StringVar()  # py变量值相同 变量名不同 他们的id内存地址也是一样的 因此两组选择控件会冲突 不建议参数变量直接用int型 而是StringVar
r_way.set('SRCNN')
radio_way = tk.Radiobutton(f2, text='SRCNN', variable=r_way, value='SRCNN',
                           command=lambda: gui.func_Ways(ch='SRCNN', listbox=list_model))
radio_way2 = tk.Radiobutton(f2, text='FSRCNN', variable=r_way, value='FSRCNN',
                            command=lambda: gui.func_Ways(ch='FSRCNN', listbox=list_model))
""" 单选 视频/图像 """
r_vi = StringVar()
r_vi.set('image')
radio_vi = tk.Radiobutton(f2, text='视频', variable=r_vi, value='video',
                          command=lambda: gui.func_VideoImage(
                              ch='video', radio1=radio_way, radio2=radio_way2, listbox=list_model, r_way=r_way))
radio_vi2 = tk.Radiobutton(f2, text='图像', variable=r_vi, value='image',
                           command=lambda: gui.func_VideoImage(
                               ch='image', radio1=radio_way, radio2=radio_way2, listbox=list_model, r_way=r_way))
""" 布局 """
title_chvi.grid(row=0, column=0, padx=40, pady=10)
radio_vi.grid(row=2, column=0, padx=0, pady=0)
radio_vi2.grid(row=1, column=0, padx=0, pady=0)
title_chways.grid(row=0, column=1, padx=80, pady=0)
radio_way.grid(row=1, column=1, padx=0, pady=0)
radio_way2.grid(row=2, column=1, padx=0, pady=0)
title_model.grid(row=0, column=2, padx=0, pady=0)
fl.grid(row=0, rowspan=3, column=3, padx=0, pady=4)
fl.grid_propagate(0)
list_model.pack(side="left", fill="y")
scroll_model.pack(side="right", fill="both")

#
# list_model.grid(row=0, rowspan=3, column=3, padx=0, pady=4)
# scroll_model.grid(row=0, rowspan=3, column=4, padx=0, pady=4)


""" 主窗口循环显示 """
window.mainloop()
# 没有mainloop 则是静态window 传入值不会有循环
# window.mainloop会让window不断刷新
# mainloop相当很大的while循环 点击一次更新一次
