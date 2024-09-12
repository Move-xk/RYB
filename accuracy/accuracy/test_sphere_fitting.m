% %% https://blog.csdn.net/maple_2014/article/details/121644327
% clc
% clear
% close all

%% 生成带误差的三维点
% err = 0.1;
% pointCount = 100;
% R = 50;
% theta = 2*pi*rand(pointCount, 1);
% phi = pi*rand(pointCount, 1);
% deltaR = -err + 2 * err * rand(pointCount, 1);
% x = (R + deltaR) .* sin(phi) .* cos(theta);
% y = (R + deltaR) .* sin(phi) .* sin(theta);
% z = (R + deltaR) .* cos(phi);
a = load('D:\Workfile\20230614 二维码精度验证\qumian2_points.txt');

a=pos;

%%
x = a(:,1);
y = a(:,2);
z = a(:,3);
pointCount= size(a,1);
figure(1)
plot3(x, y, z, 'ro')
hold on

%% 球面最小二乘拟合
crossStartAndEndPointFlag = 0; %0:不经过给定起点与终点;  1:精确经过给定起点与终点
[ center, r, fittingError ] = sphere_fitting( [x, y, z], pointCount, crossStartAndEndPointFlag )
maxFittingError = max(abs(fittingError))
[xx, yy, zz] = sphere(50);
xx = r * xx + center(1);
yy = r * yy + center(2);
zz = r * zz + center(3);
h = surf(xx, yy, zz);
set(h, 'FaceAlpha', 0.2, 'MeshStyle', 'none')
axis equal
grid on
