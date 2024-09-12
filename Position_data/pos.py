import re
import pandas as pd

# 文件路径
file_path = r'C:\Users\kk\Desktop\植体规划\中下\补充\FBC38A7B-EE64-4C54-AE0E-02CFC1A371BD中下-术后-1Verify.txt'

# 打开并读取文件内容
with open(file_path, 'r', encoding='ansi') as file:
    file_content = file.read()

# 初始化字典来存储术前和术后的坐标
coordinates = {
    '植入点术前': {},
    '植入点术后': {},
    '根尖点术前': {},
    '根尖点术后': {}
}

# 定义正则表达式来匹配术前和术后的坐标
pattern = re.compile(r'(?<=术前坐标:)([\s\S]*?)(?=术后坐标:)', re.DOTALL)

# 使用正则表达式查找术前坐标
preoperative_matches = pattern.findall(file_content)
if preoperative_matches:
    # 假设术前坐标是第一个匹配项
    preoperative_text = preoperative_matches[0]
    # 进一步提取术前每个牙位的坐标
    preoperative_lines = preoperative_text.strip().split('\n')
    for line in sorted(preoperative_lines):
        position, values = line.split(':')
        coordinates['植入点术前'][position.strip()] = list(map(float, values.strip().split()))

if preoperative_matches:
    # 假设术前坐标是第一个匹配项
    preoperative_text = preoperative_matches[1]
    # 进一步提取术前每个牙位的坐标
    preoperative_lines = preoperative_text.strip().split('\n')
    for line in sorted(preoperative_lines):
        position, values = line.split(':')
        coordinates['根尖点术前'][position.strip()] = list(map(float, values.strip().split()))

# 再次使用正则表达式查找术后坐标
# 需要重新编译正则表达式，以匹配术后坐标
postoperative_pattern = re.compile(r'(?<=术后坐标:)([\s\S]*?)(?=\n\n牙位)', re.DOTALL)
postoperative_matches = postoperative_pattern.findall(file_content)
if postoperative_matches:
    # 假设术后坐标是第一个匹配项
    postoperative_text = postoperative_matches[0]
    # 进一步提取术后每个牙位的坐标
    postoperative_lines = postoperative_text.strip().split('\n')
    for line in sorted(postoperative_lines):
        position, values = line.split(':')
        coordinates['植入点术后'][position.strip()] = list(map(float, values.strip().split()))

if postoperative_matches:
    # 假设术后坐标是第一个匹配项
    postoperative_text = postoperative_matches[1]
    # 进一步提取术后每个牙位的坐标
    postoperative_lines = postoperative_text.strip().split('\n')
    for line in sorted(postoperative_lines):
        position, values = line.split(':')
        coordinates['根尖点术后'][position.strip()] = (list(map(float, values.strip().split())))

# 打印提取的坐标
print("植入点术前坐标:", coordinates['植入点术前'])
print("植入点术后坐标:", coordinates['植入点术后'])
print("根尖点术前坐标:", coordinates['根尖点术前'])
print("根尖点术后坐标:", coordinates['根尖点术后'])

df = pd.DataFrame.from_dict(coordinates, orient='index')
excel_filename = 'position_data.xlsx'
df.to_excel(excel_filename, index=True, header=True, engine='openpyxl')

print(f'嵌套数据已导出到 {excel_filename}')
