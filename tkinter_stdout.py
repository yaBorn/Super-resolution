"""
    重定向输出

        此文件作用 python输出流定向：
            将 print 输出重定向到 tkinter.Text控件上
            Python文件对象 sys.stdin sys.stdout sys.stderr -对应-> 解释器标准输入 标准输出 标准出错流

        未重定向 os.system(cmd)：
            即 python通过cmd命令行调用mat.exe输出信息 仍在控制台
            替换 sys.stdout 不影响由 os.popen() os.system() os.exec*()方法所创建进程的标准I/O流

        os重定向方法：
            os.system(cmd)返回脚本的退出状态码 os.popen(cmd)返回脚本执行过程中的输出file对象
            os.system()不能获得输出，可用os.popen系列函数获得外部程序的输出
                os.system(cmd)
                ->
                f = os.popen(cmd, "r")
                d = f.read()  # 读文件
                print(d)
                print(type(d))
                f.close()
"""
import sys
import tkinter


class myStdout:
    """ 重定向类"""
    def __init__(self, textbox):  # 初始化
        self.textbox = textbox
        # 将其备份
        self.stdoutbak = sys.stdout
        self.stderrbak = sys.stderr
        # 重定向
        sys.stdout = self
        sys.stderr = self

    def write(self, info):
        # info信息 即标准输出sys.stdout和sys.stderr接收的输出信息
        self.textbox.insert('end', info)  # text控件最后一行插入print信息
        self.textbox.update()  # 更新显示
        self.textbox.see(tkinter.END)  # 始终显示最后一行 不加这句:文本溢出控件最后一行时，不会自动显示最后一行

    def restoreStd(self):
        # 恢复标准输出
        sys.stdout = self.stdoutbak
        sys.stderr = self.stderrbak


""" 用例
    mystd = myStdout(tk.text)  # 实例化重定向类
    ...
    window.mainloop()  # 显示窗体
    mystd.restoreStd()  # 恢复标准输出
"""

