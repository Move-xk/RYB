clc 
clear
% a = load('D:\Workfile\20230614 二维码精度验证\骨叉\持骨器（2）-曲面.txt');
a = load('D:\data\marker_pose.txt');


for i=1:8
    ind_start=0+i;
    ind = (0+i):8:40;
    one_a = a(ind,:);
    avg_pos = mean(one_a);
    for j=1:size(one_a,1)
      diff_pos(i,j) = norm(avg_pos-one_a(j,:));
    end
end
    

figure(1)
clf
hold on
m = mean(diff_pos,2);
e = std(diff_pos,0,2);
errorbar(m,e)
grid on
% xlim([0,9])
% ylim([0,0.6])


a = load('D:\Workfile\20230614 二维码精度验证\骨叉\持骨器（2）-marker（A158）.txt');
for i=1:8
    ind_start=0+i;
    ind = (0+i):8:40;
    one_a = a(ind,:);
    avg_pos = mean(one_a);
    for j=1:size(one_a,1)
      diff_pos(i,j) = norm(avg_pos-one_a(j,:));
    end
end
    

m = mean(diff_pos,2);
e = std(diff_pos,0,2);
errorbar(m,e)
grid on
xlim([0,9])
ylim([0,0.6])
title('八个球坑的误差分布')
legend('患者下','曲面下 ')
