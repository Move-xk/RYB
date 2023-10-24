from pywinauto.application import Application
from pywinauto import mouse
from pywinauto.keyboard import send_keys
import tkinter as tk
from tkinter import filedialog  # 标准的GUI库
# from tkinter import messagebox
import shutil  # os的一个模块用作对压缩包的处理，Zipfile和TarFile
import time
import sys  # python解释器交互的模块
import os


class Logger(object):
    def __init__(self, file_name="Default.log"):
        self.terminal = sys.stdout
        self.log = open(file_name, "w+", encoding="utf-8")

    def write(self, message):
        self.terminal.write(message)
        self.log.write(message)
        self.terminal.flush()
        self.log.flush()

    def flush(self):
        self.terminal.flush()
        self.log.flush()

    # E:\\ai_test\\data_all\\brand4_name69_UpperJaw.stl
    # E:\\ai_test\data_all\\brand4_name78_UpperJaw.stl
    # E:\\ai_test\data_all\\brand4_name33_UpperJaw.stl
    # E:\\ai_test\data_all\\brand5_name26_LowerJaw.stl
    # E:\\ai_test\data_all\\brand5_name18_UpperJaw.stl
    # E:\\ai_test\data_all\\brand5_name11_LowerJaw.stl
    # E:\\ai_test\data_all\\brand4_name94_UpperJaw.stl


def movefile(oripath, tardir):
    filename = oripath.split("\\")[-1]
    tarpath = os.path.join(tardir, filename)
    # 判断目标文件夹是否存在
    if os.path.exists(tardir):
        # 判断目标文件夹里原始文件是否存在，存在则删除
        if os.path.exists(tarpath):
            os.remove(tarpath)
    else:
        # 目标文件夹不存在则创建目标文件夹
        os.makedirs(tardir)
        # 移动文件
        shutil.move(oripath, tardir)


def record(massage):
    current_time = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    out = current_time + " " + massage + "\n"
    print(out, end="")


def get_files_list(file_path, all_files):
    file_list = os.listdir(file_path)
    for file in file_list:
        cur_path = os.path.join(file_path, file)
        if os.path.isdir(cur_path):
            # get_files_list(cur_path, all_files)
            pass
        else:
            if ".gz" in cur_path:
                all_files.append(cur_path)
    return all_files


def change_label(self):
    num = 0
    ITK_path = entry_name_ITK.get()
    data_path = entry_name_data.get()
    label_path = entry_name_label.get()

    # 遍历data和label文件
    files_list = get_files_list(data_path, [])
    total = len(files_list)
    tem_record = "data文件总数：" + str(total)
    record(tem_record)
    labels_list = get_files_list(label_path, [])
    # print(labels_list[0])
    # time.sleep(100)

    for files_name in files_list:
        app = Application(backend="uia").start(ITK_path)
        win = app.window(title_re="ITK-SNAP")
        win.wait(wait_for="ready")
        win.maximize()

        win["File"].select()

        win["Open Image ..."].click()

        data_edit = win["Image Filename:Edit"]

        tem_list = files_name.split(" ")
        # 输入项目名称，有空格，所以需要循环输入
        for i in range(len(tem_list)):
            data_edit.type_keys(tem_list[i])
            if i != len(tem_list) - 1:
                data_edit.type_keys("{VK_SPACE}")

        win['Next > EnterButton'].click()
        # log记录
        tmp_record = "导入病例：" + files_name.split("\\")[-1]
        record(tmp_record)

        # 加载完以后需要重新定位窗口
        new_window_name = files_name.split("\\")[-1] + " - New Segmentation - ITK-SNAP"

        win = app.window(title_re=new_window_name)
        win.wait(wait_for="ready")
        win["Finish Enter"].click()
        win["还原"].click()
        win["最大化"].click()
        send_keys("^O")

        # 输入label
        data_edit = win["Image Filename:Edit"]
        count = 0
        for i in range(len(labels_list)):
            if files_name.split("\\")[-1] in labels_list[i]:
                tem_list = labels_list[i].split(" ")
                for j in range(len(tem_list)):
                    data_edit.type_keys(tem_list[j])
                    if j < len(tem_list) - 1:
                        data_edit.type_keys("{VK_SPACE}")
                completed_label = labels_list[i]
                break
            count = count + 1

        # 如果没找到label，退出本次循环
        if count == len(labels_list):
            win["Cancel"].click()
            win.wait(wait_for="ready")
            win['关闭'].click()
            win.wait_not(wait_for_not="exists")

            # 移动问题data
            movefile(files_name, ".\\ErrorData")
            num = num + 1
            tmp_record = "未找到与“" + files_name.split("\\")[-1] + "”同名的label" + " 剩余data数量：" + str(
                total - num)
            record(tmp_record)
            continue

        tmp_record = "导入label：" + files_name.split("\\")[-1]
        record(tmp_record)
        win["Next > EnterButton"].click()

        # 加载完以后需要重新定位窗口
        new_window_name = files_name.split("\\")[-1] + " - " + files_name.split("\\")[-1] + " - ITK-SNAP"
        win = app.window(title_re=new_window_name)
        # win.print_control_identifiers()
        win["Finish Enter"].click()
        win["Segmentation"].select()
        win["Label Editor ..."].click()

        # 定位标签窗口
        Available_Labels_Group = win['Available Labels:GroupBox']
        # 获取窗口位置
        rectangle = str(Available_Labels_Group.get_properties()["rectangle"])
        # print(rectangle)
        left = int(rectangle[2:5]) + 50
        top = int(rectangle[8:11]) + 100
        mouse.click(coords=(left, top))

        # 找到最大值
        mouse.scroll(coords=(left, top), wheel_dist=-30)
        Available_Labels_Group = win['Available Labels:GroupBox']
        Available_Labels_Group.print_control_identifiers(filename="tmp.txt")
        f = open("tmp.txt").readlines()
        tmp = []
        for l in f:
            if "DataItem - 'Label" in l:
                tmp.append(l)
        label = (tmp[-1].split("'")[1]).split(" ")
        max_label = int(label[1])
        if max_label > 55:
            max_label = 55
        mouse.scroll(coords=(left, top), wheel_dist=30)

        # log记录
        tmp_record = "最大标签数值为：" + str(max_label)
        record(tmp_record)

        # 定位到第一个标签
        Selected_Labels = win['Selected Label']
        # Selected_Labels.print_control_identifiers()
        label0 = win["DataItem"]
        rectangle = str(label0.get_properties()["rectangle"])
        left = int(rectangle[2:5]) + 10
        top = int(rectangle[8:11]) + 30
        # 循环改标签
        for i in range(max_label):
            mouse.double_click(coords=(left, top))
            time.sleep(1.7)
            mouse.click(coords=(left + 344, top))
            send_keys("00")
            time.sleep(0.5)
            mouse.click(coords=(left + 440, top + 355))
            send_keys("00")
            time.sleep(0.5)
        send_keys("{ENTER}")
        time.sleep(0.5)
        send_keys("{ENTER}")

        win["Close"].click()
        win.wait(wait_for="ready")
        win['关闭'].click()

        # 定位保存页面
        win = app.window(title_re="Save Changes - ITK-SNAP")
        win.wait(wait_for="ready")
        win["Save All"].click()
        win.wait_not(wait_for_not="exists")
        # 移动完成后的文件
        movefile(files_name, ".\\CompletedData")
        num = num + 1
        # log记录
        tmp_record = files_name.split("\\")[-1] + "处理完成" + " 已处理data数量：" + str(
            num) + " 剩余data数量：" + str(
            total - num)
        record(tmp_record)


def test():
    print("test")


def select_ITK_file():
    entry_name_ITK.delete(0)
    path = filedialog.askopenfilename(filetypes=[("ITK", [".exe"])])
    ITK_name.set(path)


def select_data_file():
    entry_name_data.delete(0)
    path = filedialog.askopenfilename(filetypes=[("data", [".gz"])])
    tmp = path.split("/")
    tmp_index = len(path) - len((tmp[-1])) - 1
    path = path[:tmp_index]
    data_name.set(path)


def select_label_file():
    entry_name_label.delete(0)
    path = filedialog.askopenfilename(filetypes=[("data", [".gz"])])
    tmp = path.split("/")
    tmp_index = len(path) - len((tmp[-1])) - 1
    path = path[:tmp_index]
    label_name.set(path)


dir_name = '.\\Log\\'
if not os.path.exists(dir_name):
    os.mkdir(dir_name)

# 重写print
sys.stdout = Logger('.\\Log\\record.txt')

window = tk.Tk()
window.title('label预处理')
window.geometry('600x200')

# 画标签
tk.Label(window, text="ITK-SANP 路径：").place(x=5, y=30)
tk.Label(window, text="DATA 路径：").place(x=5, y=70)
tk.Label(window, text="LABEL 路径：").place(x=5, y=110)

# 文件输入路径变量
ITK_name = tk.StringVar()
data_name = tk.StringVar()
label_name = tk.StringVar()

# 输出地址
entry_name_ITK = tk.Entry(window, textvariable=ITK_name, width=55)
entry_name_ITK.place(x=110, y=30)
entry_name_data = tk.Entry(window, textvariable=data_name, width=55)
entry_name_data.place(x=110, y=70)
entry_name_label = tk.Entry(window, textvariable=label_name, width=55)
entry_name_label.place(x=110, y=110)

# 画按钮
tk.Button(window, text="路径选择", command=select_ITK_file).place(x=500, y=25)
tk.Button(window, text="路径选择", command=select_data_file).place(x=500, y=65)
tk.Button(window, text="路径选择", command=select_label_file).place(x=500, y=105)
tk.Button(window, text="确认", command=change_label).place(x=290, y=150)
# tk.Button(window, text = "确认", command = test).place(x=290,y=150)

window.mainloop()
