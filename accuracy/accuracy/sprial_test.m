% 清空命令窗口和工作空间
clc;
clear;

% % 定义参数
% a = pi; % 螺线的参数
% b = [linspace(0, 1, 1500) ones(1,500)]; 
% t = linspace(0, 10*pi, 2000); % 参数范围
% r=a+b*t
% % 计算螺线的坐标
% x = a*cos(t).*b;
% y = a*sin(t).*b;
% % z = t; % 如果需要绘制三维螺线，可以添加一个 z 分量


tt=linspace(0, 2*pi, 300); % 参数范围
rx=3.3.*cos(tt);
ry=3.3.*sin(tt);


% 绘制螺线
figure(1)
clf
hold on
grid on; % 显示网格
axis equal; % 设置坐标轴比例相等
title('螺线');
xlabel('x');
ylabel('y');
% zlabel('z');
plot(rx,ry)

% tt=linspace(0, 2*pi, 300); % 参数范围
% rx=0.75.*cos(tt);
% ry=0.75.*sin(tt);
% plot(rx,ry)
%%
a=0;
b=0.5252;
t = linspace(0, 4*pi, 1000); % 参数范围
r=(a+t*b);
x=r.*cos(t);
y=r.*sin(t);
plot(x, y);

%%
a=1.3165;
r=a.*t.^0.5;
x=r.*cos(t);
y=r.*sin(t);
plot(x, y);

%%
a=1;
b=0.19;
r=a.*exp(b*t);
x=r.*cos(t);
y=r.*sin(t);
plot(x, y);








