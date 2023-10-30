import os

# 指定文件夹路径
data_path = r'D:\DCM数据'
# 指定要保留的文件类型
save_file = '.dcm'


def remove_file(folder_path, file_extension):
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            # 判断文件类型是否是指定的类型
            if file.endswith(file_extension):
                pass
            else:
                file_path = os.path.join(root, file)
                # 执行删除操作
                os.remove(file_path)


remove_file(data_path, save_file)
