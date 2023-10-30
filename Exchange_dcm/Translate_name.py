import os
import re
from translate import Translator

folder_path = r'D:\DCM数据'


def translate_file(path):
    for file in os.listdir(path):
        file_path = os.path.join(path, file)
        if os.path.isfile(file_path):
            hospital_zh_name = folder_path[9:]
            hospital_en_name = Translator(from_lang="zh", to_lang="en").translate(hospital_zh_name)
            new_path = (folder_path[:9] + hospital_en_name)
            os.rename(folder_path, new_path)
    print('医院名称更改完成')


translate_file(folder_path)
