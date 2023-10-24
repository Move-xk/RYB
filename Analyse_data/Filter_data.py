import os
import re

dir_path = "E:\\Scripts\\Analyse_data\\Articulators"


# def traverse_dir(path):
#     for file in os.listdir(path):
#         file_path = os.path.join(path, file)
#         if os.path.isdir(file_path):
#             print("文件夹：", file_path)
#             traverse_dir(file_path)
#         else:
#             test_data = re.search(re.compile('(?i)\.dcm$'), file_path)
#             if test_data:
#                 print("文件：", file_path)
#
#
# print('待遍历的目录为：', dir_path)
# print('遍历结果为：')
# traverse_dir(dir_path)
def traverse_dir(path, data=[]):
    for file in os.listdir(path):
        file_path = os.path.join(path, file)
        if os.path.isfile(file_path):
            test_data = re.search(re.compile('(?i)\.dcm$'), file_path)
            if test_data:
                data.append(file_path)
                # return file_path
                print(data)
        else:
            traverse_dir(file_path)


traverse_dir(dir_path)

import os


# 找到最深文件夹路径的函数。folder为根文件夹的路径
def find_deepest_folder(folder):
    # deepestFolders用来存储最后需要返回的最深文件夹，因为可能存在多个同样深度的，所以是一个列表
    # 初始化为输入的目录，即若输入的目录中一个子文件件都不存在，那么返回输入的文件夹
    deepestFolders = [folder]
    # 记录最深的文件夹路径的层级，以路径分隔符切割。
    # 这里的/是linux系统的切割符，若为windows系统，这里的路径切割符可能需要替换
    maxDeep = len(folder.split('/'))
    # 开始遍历文件夹下的所有目录
    for root, dirs, files in os.walk(folder):
        # 若dirs有值，则代表还有子文件夹，那么这一层的root就不用考虑了。即只需要考虑没有子文件夹的情况
        if len(dirs) == 0:
            folderDeep = len(root.split('/'))
            if folderDeep > maxDeep:
                # 若遍历到的这个文件夹路径大于当前记录的最深路径，那么最深的就做个替换
                deepestFolders = [root]
                maxDeep = folderDeep
            elif folderDeep == maxDeep:
                # 若相同，则追加
                deepestFolders.append(root)
    return deepestFolders

# import os
# q = [] # 用来存所有文件
# path = ‘’ # 文件夹的路径 可以是绝对也可以是相对
# for root, dirs, files in os.walk(path):
#     for name in files:
#         # 将文件名逐个放入q
#         q.append(root + '/' +name)
