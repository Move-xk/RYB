import os


data_path = r'D:\DCM数据'


def delete_empty_folders(path):
    if not os.path.isdir(path):  # 检查路径是否是文件夹
        return

    for folder_name in os.listdir(path):  # 遍历当前路径下的所有文件和文件夹
        folder_path = os.path.join(path, folder_name)  # 获取文件夹的完整路径
        if os.path.isdir(folder_path):  # 如果是文件夹
            delete_empty_folders(folder_path)  # 递归调用函数，进入子文件夹
            if not os.listdir(folder_path):  # 如果子文件夹为空
                os.rmdir(folder_path)  # 删除空文件夹


# 调用函数，指定路径删除空文件夹
delete_empty_folders(data_path)
