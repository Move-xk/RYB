import os


def openreadtxt(file_name):
    data = []
    file = open(file_name, 'r')  # 打开文件
    file_data = file.readlines()  # 读取所有行
    for row in file_data:
        tmp_list = row.split('"')  # 按‘，’切分每行的数据
        tmp_list[-1] = tmp_list[-1].replace('\n', ',')  # 去掉换行符
        data.append(tmp_list)  # 将每行数据插入data中
    return data


if __name__ == "__main__":
    path = 'E:\\Scripts\\Data\\markerData\\'
    filenames = os.listdir(path)
    New_file = open("E:\\Scripts\\Data\\markerData\\data.txt", "w")
    for filename in filenames:
        file_path = path + filename
        data = openreadtxt(file_path)
        print(data)
        for item in data:
            New_file.write(str(item) + '\n')
