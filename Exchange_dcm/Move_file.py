import os
import re
import shutil

file_source = r'D:\DCM数据'


def traverse_dir(path):
    for file in os.listdir(path):
        file_path = os.path.join(path, file)
        if os.path.isfile(file_path):
            New_path = re.search(r'D:\\.*?\\.*?\\.*?\\', file_path).group(0)
            shutil.move(file_path, New_path)
        else:
            traverse_dir(file_path)


traverse_dir(file_source)
