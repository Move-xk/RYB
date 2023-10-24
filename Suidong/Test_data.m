clc; clear;
 
filename = 'Text_data.txt';
filepath = 'D:';
 
ff=fullfile(filepath, filename);
if (exist(ff)==0)
    error('文件地址不存在')
end
 
fid = fopen(ff);  %%一般是返回一个代号
data = textscan(fid,' %s %f %f %f %f %f %f %f %f %f %f %f %f','headerlines',1);
fclose(fid);

tt=split(data{1,13},["-",":","."]);
hh=str2num(char(tt(:,4)));
mm=str2num(char(tt(:,5)));
ss=str2num(cell2mat(tt(:,6:7)));
date_time=hh*60*60+mm*60+ss*0.001;
 
x1=data{:,1};   y1=data{:,2};   z1=data{:,3};
x2=data{:,7};   y2=data{:,8};   z2=data{:,9};
 
index=[10:600];
index2=index+4;
 
p1 = sqrt((x1(index)-x1(index(1))).^2+(y1(index)-y1(index(1))).^2+(z1(index)-z1(index(1))).^2);
p2 = sqrt((x2(index2)-x2(index2(1))).^2+(y2(index2)-y2(index2(1))).^2+(z2(index2)-z2(index2(1))).^2);
 
figure(1)
clf
hold on
grid on
plot(date_time(index)-date_time(index(1)),p1,'linewidth',2)
plot(date_time(index2)-date_time(index2(1)),p2,'linewidth',2)
plot(date_time(index)-date_time(index(1)),abs(p2-p1),'linewidth',2)
 
pos_error= mean(abs(p2-p1));
delay_time=date_time(index2(1))-date_time(index(1));
title(['延时' num2str(delay_time) 's, 平均误差' num2str(pos_error)  'mm' ])
xlabel('时间（s）)')
ylabel('位移（）mm)')
set(gca,'FontSize',14);
legend('Marker in cam','Robot in cam')