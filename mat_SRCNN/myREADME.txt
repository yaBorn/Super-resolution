/* SRCNN_test
 *  	matlab R2020a 编写，需安装 MATLAB Compiler 进行 exe 打包
 *
 *	文件：
 * 		SRCNN.m：	SRCNN 函数（分辨率不变，重建细节）
 * 		SRCNN_demo.m：	对 SRCNN 函数测试
 * 		SRCNN_exe.m：	输入 in 路径；out 路径；model 路径。输出 SRCNN 重建后文件。
 *					为参数函数，通过 matlab 命令：mcc -m SRCNNexe.m 生成 exe 文件。
 * 					python 程序使用 os.system 方法调用 exe
 * 					或者 作为 cmd 命令行使用
 * 		SRCNN_exe_demo.m：对 SRCNN_exe 函数测试
 *
 * 	exe使用方法：
 * 		cmd命令行：
 *          1. 打开 cmd, cd 到 exe 根目录
 *          2. 按顺序严格输入 input, output, model路径（相对路径，绝对路径测试通过）
 *                  SRCNNexe.exe cat.jpg cat_out.jpg Model\SRCNN\9-1-5(ImageNet)\x3.mat
 *                  可修改exe名称: SRCNN.exe cat.jpg cat_out.jpg Model\SRCNN\9-1-5(ImageNet)\x3.mat
 *
 * TODO
 *      1. function SRCNN_exe(input, output, model) 顺序改为不严格/缺省, 增加健硕性
 *   OK 2. cmd 运行时，打印运算过程
 *      3. README.txt -> .md
*/