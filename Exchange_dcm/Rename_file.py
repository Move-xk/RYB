# encoding: utf-8
import re
from translate import Translator
from translate import Translator

data_path = '孙启贞_2023-04-12_手术病例_1'  # folder_path


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
    print(New_name)

rename_file(data_path)
