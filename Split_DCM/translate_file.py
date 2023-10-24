import os

file = r'H:\春霞_0925'
def traverse_dir(path):
    for file in os.listdir(path):
        file_path = os.path.join(path, file)
        if os.path.isfile(file_path):
            print(file_path)
        else:
            traverse_dir(file_path)

traverse_dir(file)