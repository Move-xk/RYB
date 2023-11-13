import serial
import serial.tools.list_ports

bytesize_hex = '0x08'
bytesize_int = int(bytesize_hex, 16)

ser = serial.Serial(port="COM11",
                    baudrate=115200,
                    bytesize=bytesize_int,
                    parity=serial.PARITY_NONE,
                    stopbits=serial.STOPBITS_ONE,
                    timeout=0.5)  # 打开COM11，将波特率配置为115200，其余参数使用默认值
if ser.isOpen():  # 判断串口是否成功打开
    print("打开串口成功。")
    print(ser.name)  # 输出串口号
else:
    print("打开串口失败。")
# write_len = ser.write("FF AA 27 40 00".encode('utf-8'))
# print("串口发出{}个字节。".format(write_len))

while True:
    com_input = ser.read(10)
    if com_input:  # 如果读取结果非空，则输出
        print(com_input)
