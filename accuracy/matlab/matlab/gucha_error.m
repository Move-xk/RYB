clc;clear
clf;

data1 = load('\\192.168.10.28\1.ryb\2.个人共享\许堃\Marker数据采集\新骨叉安装的重复性误差\安装重复性误差\第四次.txt');
data2 = load('\\192.168.10.28\1.ryb\2.个人共享\许堃\Marker数据采集\新骨叉安装的重复性误差\安装重复性误差\第五次.txt');

pos_error = [];
for i = 1:8 
    pos_1= [data1(i,1),data1(i,2),data1(i,3)];
    pos_2 = [data2(i,1),data2(i,2),data2(i,3)];
    pos_error_i = pos_1 - pos_2;
    pos_error(i,:) = pos_error_i;
end

avg_pos_x = mean(pos_error(:,1));
avg_pos_y = mean(pos_error(:,2));
avg_pos_z = mean(pos_error(:,3));

bar(abs(pos_error));
legend('X','Y','Z');
title('两次骨叉安装的重复性误差')
hold on 
grid on