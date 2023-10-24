import re
import os
import time
import pywinauto
import pyautogui
from pywinauto.application import Application
from pywinauto.keyboard import send_keys
from pywinauto import mouse

software_path = r'E:\Exchange 8.4.10\Exchange 8.4.10\sys\exec64\sdx.exe'
data_path = "E:\\Scripts\\Analyse_data\\Articulators"


def traverse_dir(path, data_list=[]):
    for file in os.listdir(path):
        file_path = os.path.join(path, file)
        if os.path.isfile(file_path):
            test_data = re.search(re.compile('(?i)\.dcm$'), file_path)
            if test_data:
                data_list.append(file_path)
        else:
            traverse_dir(file_path)
    return data_list


def output_data(win):
    send_keys("^E")
    send_keys("%Y")
    mouse.click(coords=(911, 587))
    mouse.click(coords=(834, 882))
    win["输出"].click()
    time.sleep(1)
    win["进行转换"].click()
    time.sleep(1)
    win["確認"].click()
    time.sleep(1)
    win["接受"].click()
    mouse.click(coords=(1909, 34))


def open_software(path):
    app = Application(backend='uia').start(path)
    time.sleep(5)
    win = app.window(class_name="wxMDIFrameNR")
    win.maximize()
    time.sleep(2)
    n = 0
    m = 0
    for data in traverse_dir(data_path):
        send_keys("^I")
        time.sleep(1)
        input_win = pywinauto.Application().connect(title='输入文件细节')  # 连接弹窗窗口
        win["浏览"].click()
        dlg = input_win.Dialog  # 获取窗口句柄
        dlg["Edit"].set_text(data)  # 在文本框中输入文件路径
        time.sleep(2)
        send_keys("{VK_RETURN}")  # 点击确定
        win["输入"].click()
        time.sleep(1)
        # warning_win = pywinauto.Application().connect(title='Exchange', backend='win32', visible_only=False)  # 连接弹窗窗口
        x, y = (709, 487)
        color = pyautogui.pixel(x, y)
        a, b = (811, 486)
        color_normal = pyautogui.pixel(a, b)
        if color == (240, 58, 23):
            m = m + 1
            win["確認"].click()
            win["接受"].click()
            print('数据：' + data + '异常，请处理')
        else:
            if color_normal == (0, 120, 215):
                win["確認"].click()
                win["接受"].click()
                output_data(win)
                n = n + 1
            else:
                output_data(win)
                n = n + 1

    # top_win = Exchange_app.top_window()
    win.close()
    print('数据转换完成,成功转换' + str(n) + '条数据，失败转换' + str(m) + '条数据')


if __name__ == '__main__':
    open_software(software_path)
