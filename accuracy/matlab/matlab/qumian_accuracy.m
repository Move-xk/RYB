clc;
clear;

% data = load('\\192.168.10.28\1.ryb\2.个人共享\许堃\Marker数据采集\曲面数据采集\平\x_Refine_x_code_000_059data.txt');
% data = load('\\192.168.10.28\1.ryb\2.个人共享\许堃\Marker数据采集\曲面数据采集\仰\x_Refine_x_code_000_059data.txt');
data = load('\\192.168.10.28\1.ryb\2.个人共享\许堃\Marker数据采集\曲面数据采集\只看到斜面\x_Refine_x_code_000_059data.txt');

pos = data(:,2:4);
x = pos(:,1);   y = pos(:,2);   z = pos(:,3);
avg_x = mean(x);    avg_y = mean(y);    avg_z = mean(z);    %平均
var_x = var(x);     var_y = var(y);     var_z = var(z);     %方差
standar_x = std(x);     standar_y = std(y);     standar_z = std(z);     %标准差
error_x = x - avg_x;    error_y = y - avg_y;    error_z = z -avg_z;
figure(1)
clf
hold on
grid on
plot(error_x,'b+');
plot(error_y,'rd');
plot(error_z,'c*');
ylabel('与平均数的误差');
xlabel('采集量');
legend('error_x','error_y','error_z');