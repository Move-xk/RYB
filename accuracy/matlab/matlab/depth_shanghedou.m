clc
clear
data = load('\\192.168.10.28\1.ryb\2.个人共享\田飞飞\2024年\2.0 上颌窦手术分析病例\曾焕祝\Maxillary.txt');
% data = load('D:\data\20240103\Maxillary.txt');

%寻找开始点 fz不为0时开始
index = find(data(:,4)==0);
index = [index(end):size(data,1)];
%赋值
d=data(index(1),2)-data(index,2);%计算的是每个周期结束后，机械臂是往下还是往上走
f=data(index,3); %合力
fz=data(index,4);%z方向力
t=data(index,5);%时间，日志的倒数第二列
step=data(index,6);%步号，日志的最后一列

%画时间为横坐标的图
figure(1)
clf
hold on
grid on
plot(t-t(1),f,'. -') %把时间维度拉齐，均为后一个时间减去第一个时间
plot(t-t(1),fz,'. -')
plot(t-t(1),d,'.')
plot(t(2:end)-t(1),10*diff(d))  %画变化率
legend('合力','Z方向','深度','深度变化','Location','best','NumColumns',1)
ylabel('力（N) / 深度（mm）')
xlabel('时间（s)')

%画深度为横坐标的图
figure(2)
clf
hold on
grid on
%所有点
plot(d,f,'o ','color','#0072BD')
plot(d,fz,'o ','color','#D95319')

%寻找每个深度的最大值
[dd,m,n]= unique(d);
mm=[];
mmz=[];
for k=1:size(m,1)
    mm = [mm, max(f(find(d==d(m(k)))))];
    mmz = [mmz, max(fz(find(d==d(m(k)))))];
end

%最大值连线
plot(d(m),mm,'o -','color','#0072BD')
plot(d(m),mmz,'o -','color','#D95319')

% legend('合力','轴向力','Location','northwest')
ylabel('力（N) ')
xlabel('深度（mm)')
