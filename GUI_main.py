"""
    图形界面
"""
from GUI_func import *  # 按键回调函数

window = tk.Tk()  # 实例化object，建立窗口window
window.title('Super-resolution')  # 窗口名
window.geometry('800x800')  # 设定窗口的大小(长x宽)

''' 标签 '''
title = tk.Label(window, text='你好！this is title', bg='green', font=('Arial', 12), width=30, height=2)
# 说明： bg为背景，font为字体，width为长，height为高，这里的是字符的长和高
title.pack()

''' 输入路径 '''
title_input = tk.Label(window, text='输入路径：', font=('Arial', 11), width=30, height=2)
title_input.pack(anchor="w")
# title_input.place(relx=0.1, rely=0.25, relwidth=0.8)
text_input = tk.Entry(window, show=None, state='normal')  # 无密文 可写
text_input.insert(0, "未选择...")  # 写入文本
text_input.config(state='readonly')  # 写入后设为只读
text_input.pack()
# text_input.place(relx=0.1, rely=0.25, relwidth=0.8)

''' 输出路径'''
title_output = tk.Label(window, text='输出路径：', font=('Arial', 11), width=30, height=2)
title_output.pack(anchor="w")
text_output = tk.Entry(window, show=None, state='normal')  # 无密文 可写
text_output.insert(0, "未选择...")  # 写入文本
text_output.config(state='readonly')  # 写入后设为只读
text_output.pack()
# text_output.place(relx=0.1, rely=0.4, relwidth=0.8)

''' 选择文件按钮'''
button_chooseFile = tk.Button(window, text='选择文件', font=('Arial', 11), width=10, height=1,
                              command=lambda: func_chooseFile(entryInput=text_input, entryOutput=text_output))
# command是按钮回调函数 lambda: 传递参数
button_chooseFile.pack()

''' 模型选择'''
# 创建List变量并为其添加内容
l_model = tk.StringVar()
l_model.set((1, 2, 3, 4))  # 为变量var2设置值
# 创建list组件
list_model = tk.Listbox(window, listvariable=l_model)
# 值循环添加到Listbox控件中
list_items = [11, 22, 33, 44]
for item in list_items:
    list_model.insert('end', item)  # 从最后一个位置开始加入值
list_model.pack()

''' 算法选择'''
title_chways = tk.Label(window, text='选择算法：', font=('Arial', 11), width=30, height=2)
title_chways.pack()
r_way = 'SRCNN'  # py中变量的值相同，即便变量名不同，他们对应的id内存地址是一样的 因此两组选择控件会冲突，不建议用int型
radio_way = tk.Radiobutton(window, text='SRCNN', variable=r_way, value='SRCNN',
                           command=lambda: func_Ways(ch='SRCNN'))
radio_way.pack()
radio_way2 = tk.Radiobutton(window, text='FSRCNN', variable=r_way, value='FSRCNN',
                            command=lambda: func_Ways(ch='FSRCNN'))
radio_way2.pack()

''' 视频/图像超分 单选'''
# 创建n个radiobutton选项
# 其中variable=var,
# value='A'的意思就是，当鼠标选中了其中一个选项，把value赋值variable的参数
title_chvi = tk.Label(window, text='视频/图像超分：', font=('Arial', 11), width=30, height=2)
title_chvi.pack()
r_vi = 'image'
radio_vi = tk.Radiobutton(window, text='视频', variable=r_vi, value='video',
                          command=lambda: func_VideoImage(ch='video', radio1=radio_way, radio2=radio_way2))
radio_vi.pack()
radio_vi2 = tk.Radiobutton(window, text='图像', variable=r_vi, value='image',
                           command=lambda: func_VideoImage(ch='image', radio1=radio_way, radio2=radio_way2))
radio_vi2.pack()



# 主窗口循环显示
window.mainloop()
# 注意，loop因为是循环的意思，window.mainloop就会让window不断的刷新
# 如果没有mainloop,就是一个静态的window,传入进去的值就不会有循环，
# mainloop就相当于一个很大的while循环，有个while，每点击一次就会更新一次，所以我们必须要有循环
# 所有的窗口文件都必须有类似的mainloop函数，mainloop是窗口文件的关键的关键。
