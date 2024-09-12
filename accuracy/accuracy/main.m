% clc
% clear
% close all



% a=load('D:\Workfile\20230614 二维码精度验证\20230702\基准背面-动态.txt');
% a=load('D:\data\持骨器（2）-曲面.txt');
% [x,y,z]=quat2angle(a(:,4:7));
a=pos;
% err_r=[];
% for i=1:8
%     ind_start=0+i;
% ind = (0+i):8:40;'

%%
x = a(:,1);
y = a(:,2);
z = a(:,3);
num = size(x,1);
[sphereCenter, radius] = min_enclosing_sphere(x, y, z, num);
ac=sphereCenter;
figure(1)
clf
draw_sphere(sphereCenter, radius)
hold on
grid on
plot3(x, y, z, 'r+')
plot3(sphereCenter(1),sphereCenter(2),sphereCenter(3),'bo')
txt = ['R' num2cell(radius) '(mm)'];
text(sphereCenter(1)+radius,sphereCenter(2),sphereCenter(3),txt,'FontSize',20)
axis equal tight
if sum(sqrt((x - sphereCenter(1)).^2 + (y - sphereCenter(2)).^2 + (z - sphereCenter(3)).^2) > radius + 0.0001) > 0
   disp('至少有一个点在球面以外')
end
% err_r(i)=radius;
% end


