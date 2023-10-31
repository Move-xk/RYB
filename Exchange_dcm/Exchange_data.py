# encoding: utf-8
import os
import re
import shutil
import zipfile
import rarfile
import py7zr
from translate import Translator

data_path = r'E:\DCM数据'  # DCM save path,the name must same like 'DCM数据'
save_file = '.dcm'  # remove without save_file's type
error_file = "E:/异常数据"  # save error files path


# 遍历文件夹中的每个文件

def extract_file(path, error_file_path):
    for hospital_name in os.listdir(path):
        folder_path = os.path.join(path, hospital_name)
        for filename in os.listdir(folder_path):
            file_path = os.path.join(folder_path, filename)
            if not os.path.exists(error_file_path):
                os.makedirs(error_file_path)
            else:
                extract_error(file_path, folder_path, error_file_path)


def extract_error(file_path, folder_path, error_file_path):
    if zipfile.is_zipfile(file_path):
        try:
            extract_zipfile(file_path, folder_path)
            print('DCM数据解压完成', file_path)
        except:
            shutil.move(file_path, error_file_path)
            print('DCM数据异常', file_path)
    if rarfile.is_rarfile(file_path):
        try:
            extract_rarfile(file_path, folder_path)
            print('DCM数据解压完成', file_path)
        except:
            shutil.move(file_path, error_file_path)
            print('DCM数据异常', file_path)
    if py7zr.is_7zfile(file_path):
        try:
            extract_py7zipfile(file_path, folder_path)
            print('DCM数据解压完成', file_path)
        except:
            shutil.move(file_path, error_file_path)
            print('DCM数据异常', file_path)


def extract_zipfile(file_path, folder_path):
    with zipfile.ZipFile(file_path, "r") as zip_ref:
        # 获取大压缩包的名称
        folder_name = os.path.splitext(os.path.basename(file_path))[0]
        # 新建一个文件夹用于存放解压后的文件
        output_folder_path = os.path.join(folder_path, rename_file(folder_name))
        os.makedirs(output_folder_path, exist_ok=True)
        for file_info in zip_ref.infolist():
            # 指定解压缩文件的编码格式（例如 gbk）
            file_info.filename = file_info.filename.encode("cp437").decode("gbk")
            zip_ref.extract(file_info, output_folder_path)


def extract_rarfile(file_path, folder_path):
    # 获取大压缩包的名称
    folder_name = os.path.splitext(os.path.basename(file_path))[0]
    # 新建一个文件夹用于存放解压后的文件
    output_folder_path = os.path.join(folder_path, rename_file(folder_name))
    os.makedirs(output_folder_path, exist_ok=True)
    rar_file = rarfile.RarFile(file_path, mode='r')
    rar_file.extractall(output_folder_path)


def extract_py7zipfile(file_path, folder_path):
    # 获取大压缩包的名称
    folder_name = os.path.splitext(os.path.basename(file_path))[0]
    # 新建一个文件夹用于存放解压后的文件
    output_folder_path = os.path.join(folder_path, rename_file(folder_name))
    os.makedirs(output_folder_path, exist_ok=True)
    py7zr_file = py7zr.SevenZipFile(file_path, mode='r')
    py7zr_file.extractall(output_folder_path)


def rename_file(folder_name):
    if '术前' in folder_name:
        zh_name = re.match(r'.*?_', folder_name).group(0)
        translation = Translator(from_lang="zh", to_lang="en").translate(zh_name)
        New_name = re.sub(r'.*?术前_1', translation + '1', folder_name)
    if '术中' in folder_name:
        zh_name = re.match(r'.*?_', folder_name).group(0)
        translation = Translator(from_lang="zh", to_lang="en").translate(zh_name)
        New_name = re.sub(r'.*?术中_1', translation + '2', folder_name)
    if '术后' in folder_name:
        zh_name = re.match(r'.*?_', folder_name).group(0)
        translation = Translator(from_lang="zh", to_lang="en").translate(zh_name)
        New_name = re.sub(r'.*?术后_1', translation + '3', folder_name)
    if '手术病例' in folder_name:
        zh_name = re.match(r'.*?_', folder_name).group(0)
        translation = Translator(from_lang="zh", to_lang="en").translate(zh_name)
        New_name = re.sub(r'.*?手术病例_1', translation + '4', folder_name)
    return New_name


def remove_file(folder_path, file_extension):
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            # 判断文件类型是否是指定的类型
            if file.endswith(file_extension):
                pass
            else:
                file_path = os.path.join(root, file)
                # 执行删除操作
                try:
                    os.remove(file_path)
                    print('删除完成', file_path)
                except:
                    print('数据异常，无法删除', file_path)
    print('非DCM数据删除完成')


def move_file(path):
    for file in os.listdir(path):
        file_path = os.path.join(path, file)
        if os.path.isfile(file_path):
            try:
                New_path = re.search(r'E:\\.*?\\.*?\\.*?\\', file_path).group(0)  # 这里也要改一下文件的路径
                shutil.move(file_path, New_path)
            except:
                print('新地址与原地址相同', file_path)
        else:
            move_file(file_path)  # 递归查找文件


def delete_empty_folders(path):
    if not os.path.isdir(path):  # 检查路径是否是文件夹
        return
    for folder_name in os.listdir(path):  # 遍历当前路径下的所有文件和文件夹
        folder_path = os.path.join(path, folder_name)  # 获取文件夹的完整路径
        if os.path.isdir(folder_path):  # 如果是文件夹
            delete_empty_folders(folder_path)  # 递归调用函数，进入子文件夹
            if not os.listdir(folder_path):  # 如果子文件夹为空
                os.rmdir(folder_path)  # 删除空文件夹
                print('删除空文件夹成功', folder_path)


def translate_file(path):
    for file in os.listdir(path):
        file_path = os.path.join(path, file)
        if os.path.isdir(file_path):
            hospital_zh_name = file_path[9:]  # 使用的是字符串拼接，需要注意路径前面的长度
            hospital_en_name = Translator(from_lang="zh", to_lang="en").translate(hospital_zh_name)
            a = hospital_en_name.replace(' ', '')
            b = a.replace(',', '')
            new_path = (file_path[:9] + b)
            os.rename(file_path, new_path)
    print('医院名称更改完成')


if __name__ == '__main__':
    extract_file(data_path, error_file)
    remove_file(data_path, save_file)
    move_file(data_path)
    delete_empty_folders(data_path)
    translate_file(data_path)
print('DCM转换已完成，请处理异常数据')
