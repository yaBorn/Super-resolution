import tkinter as tk  # 使用Tkinter_GUI包
from tkinter import filedialog, END

"""
    程序属性配置
"""
# 格式.
format_im = ['png', 'jpeg', 'jpg', 'tiff', 'bmp']
format_vi = ['mp4']
format_file = [
    ('图像/视频', '*.png;*.jpeg;*.jpg;*.tiff;*.bmp'),
    ('图像', '*.png;*.jpeg;*.jpg;*.tiff;*.bmp'),
    ('视频', '*.mp4'),
    ('全部文件', '*.*'),
]

# 输入文件路径
file_input = ''
# 输出文件路径
file_output = ''

# 视频/图像 超分
is_VideoImage = 'image'  # 默认为图像超分

# 超分算法
#   图像超分辨率算法：SRCNN FSRCNN
#   视频超分辨率算法：EDVR
use_ways = 'SRCNN'

# 使用训练模型
use_model = "SRCNN_INx2"
# 模型
model_srcnn = [
    "SRCNN_91x2",
    "SRCNN_91x3",
    "SRCNN_91x4",
    "SRCNN_INx2",
    "SRCNN_INx3",
    "SRCNN_INx4",
]
model_fsrcnn = [
    "FSRCNN_x2",
    "FSRCNN_x3",
    "FSRCNN_x4",
    "FSRCNN_x2-s",
    "FSRCNN_x3-s",
    "FSRCNN_x4-s",
]
model_edvr = [
    "1",
]


"""
    用到的功能函数
"""


# 根据输入文件路径 得到输出文件路径
def getOutputFile(infile):
    # 分割input后缀(从右侧分割’.')
    outfile = infile.rsplit('.', 1)[0] + '_out.' + infile.rsplit('.', 1)[1]
    return outfile


# 更新 List组件
def renewList(listbox, content):
    """ 将 listbox 更新为 content"""
    global use_model
    # 清空列表
    listbox.delete(0, END)
    # 往列表里添加数据
    for item in content:
        listbox.insert("end", item)
    # 模型参数 更新为list组件首选项
    use_model = listbox.get(0)
    listbox.selection_set(0)  # 首选项选中


# 更新 算法选项组件
def renewRadioVI(radio1, radio2, listbox):
    """ 根据 程序属性配置 更新 算法选项组件"""
    global is_VideoImage
    if is_VideoImage == 'image':  # 图像
        # 更新 算法选项
        radio1.config(text='SRCNN', value='SRCNN', command=lambda: func_Ways(ch='SRCNN', listbox=listbox))
        radio2.config(text='FSRCNN', value='FSRCNN', command=lambda: func_Ways(ch='FSRCNN', listbox=listbox))

    elif is_VideoImage == 'video':  # 视频
        radio1.config(text='EDVR', value='EDVR', command=lambda: func_Ways(ch='EDVR', listbox=listbox))
        radio2.config(text='    ', value='EDVR', command=lambda: func_Ways(ch='EDVR', listbox=listbox))

    else:
        print("error：更新 算法选项 失败")
        print("     is_VideoImage：" + str(is_VideoImage))


# 检查 输入文件
def checkFileFormat(infile):
    # 检查路径
    if file_input == "" or file_output == "":
        print("error: 检查格式 路径为空 ")
        return False

    # 检查格式
    informat = infile.rsplit('.', 1)[1]
    if is_VideoImage == 'image':
        if informat in format_im:
            return True
        print("error: 检查格式 格式不匹配 ")
    elif is_VideoImage == 'video':
        if informat in format_vi:
            return True
        print("error: 检查格式 格式不匹配 ")
    else:
        print("error：检查格式 参数错误 ch-is_VideoImage:" + str(is_VideoImage))
    return False


"""
    图形界面 回调函数
"""


# 选择文件 按钮
def func_chooseFile(entryInput, entryOutput):
    # 打开文件选择对话框 返回选择文件路径
    filename = tk.filedialog.askopenfilename(
        title='选择文件',
        filetypes=format_file)
    if filename:
        # 分割字符串 处理文件路径
        global file_input, file_output
        file_input = filename
        file_output = getOutputFile(filename)
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
        print("error：选择文件 未找到该文件")


# 图像/视频 选项
def func_VideoImage(ch, radio1, radio2, listbox, r_way):
    global use_ways, is_VideoImage
    if ch == 'image':  # 图像
        # 参数更改
        is_VideoImage = ch  # 视频/图像参数
        use_ways = 'SRCNN'  # 算法参数
        r_way.set('SRCNN')  # 算法组件选中参数
        # 组件更新
        renewRadioVI(radio1, radio2, listbox)  # 更新 算法选项
        renewList(listbox, model_srcnn)  # 更新 模型列表
    elif ch == 'video':  # 视频
        is_VideoImage = ch
        use_ways = 'EDVR'
        r_way.set('EDVR')
        renewRadioVI(radio1, radio2, listbox)
        renewList(listbox, model_edvr)
    else:
        print("error：图像/视频选项 ch-is_VideoImage:" + str(ch))


# 算法 选项
def func_Ways(ch, listbox):
    global use_ways, is_VideoImage
    # 模型选项组件 更新
    if ch == 'SRCNN':
        use_ways = ch  # 算法参数 更改
        renewList(listbox, model_srcnn)  # 更新列表组件
    elif ch == 'FSRCNN':
        use_ways = ch
        renewList(listbox, model_fsrcnn)
    elif ch == 'EDVR':
        use_ways = ch
        renewList(listbox, model_edvr)
    else:
        print("error：算法选项 ch-use_ways:" + str(ch))


# 模型 选项
def func_chModel(listbox):
    global use_model
    use_model = listbox.get(listbox.curselection())  # 模型参数 更新为list组件被选中的选项
    # print("模型选择 use_model:" + str(use_model))


# 开始 按钮
def func_start():
    print("####### 开始计算 参数如下 #######")
    print("     输入路径：" + str(file_input))
    print("     输出路径：" + str(file_output))
    print("     视频/图像：" + str(is_VideoImage))
    print("     算法：" + str(use_ways))
    print("     模型：" + str(use_model))
    # 检查文件格式
    if not checkFileFormat(file_input):
        print("error：运行终止 检查文件未通过")
        return False
    print("检查文件格式：正确")

    # 调用算法


