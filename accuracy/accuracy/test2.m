%% https://zhuanlan.zhihu.com/p/600040042
% clc ;clear

% base_circle_point;%需要拟合圆的点集
% base_circle_point=[11.5713 6.9764 10.4685;...
%     11.5859 9.088 13.5831;...
%     11.5802 11.1949 14.6103;...
%     11.5542 13.312 14.7279;...
%     11.5692 15.3806 14.0576;...
%     11.5632 17.4873 12.1397;...
%     11.5598 17.8894 6.4025;...
%     11.5577 15.8714 4.0703;...
%     11.5729 13.8578 3.232;...
%     11.5657 11.8711 3.1326;...
%     11.5706 9.8797 3.7866;...
%     11.5663 7.8676 5.5348];

% base_circle_point = load('D:\Workfile\20230614 二维码精度验证\qumian2_points.txt');
% 
% 
% base_circle_point(:,4:7)=[];
base_circle_point = pos(:,1:3);

%拟合平面
point_set=base_circle_point;%需要拟合平面的点集
x=point_set(:,1);
y=point_set(:,2);
z=point_set(:,3);
l=0*x+1;
A=[x,y,l];
param=pinv(A)*z; %计算参数，（alpha,beta,gamma）
normal_vector=[-param(1),-param(2),1];%平面法向量
unitized_normal_vector=normal_vector/norm(normal_vector);%平面的单位法向量
a=-param(1);
b=-param(2);
c=1;
d=-param(3);
%建立坐标系变换，投影
o=[0 0 -d/c];
m=[1 1 -(a+b+d)/c];
om=m-o;
px=om/norm(om);
pz=unitized_normal_vector;
py=cross(pz,px);

S_P_T=[px(1) py(1) pz(1) o(1);
       px(2) py(2) pz(2) o(2);
       px(3) py(3) pz(3) o(3);
        0     0     0     1];
P_S_T=inv(S_P_T);
base_circle_point_inP=zeros(size(base_circle_point));
for i=1:size(base_circle_point,1)%坐标点变换
    temp1=base_circle_point(i,:);
    temp1(4)=1;
    an=P_S_T*temp1';
    an(3)=0;
    base_circle_point_inP(i,:)=an(1:3)';
end
%拟合圆
x=base_circle_point_inP(:,1);
y=base_circle_point_inP(:,2);
s=-(x.^2+y.^2);
l=1+0*x;
A=[-2*x,-2*y,l];
para=pinv(A)*s; %计算参数，（alpha,beta,gamma）
a=para(1);
b=para(2);
r2=a^2+b^2-para(3);
r=r2^0.5;
fit_center_of_circle_inP=[a,b,0];
%圆心变换及输出
temp=fit_center_of_circle_inP;
temp(4)=1;
fit_center_of_circle=S_P_T*temp';
fit_center_of_circle=fit_center_of_circle(1:3)';
fit_center_of_circle  %拟合出来的圆心
r                     %圆的半径

figure(1)
% clf
hold on
[xx, yy, zz] = sphere(50);
xx = r * xx + fit_center_of_circle(1);
yy = r * yy + fit_center_of_circle(2);
zz = r * zz + fit_center_of_circle(3);
h = surf(xx, yy, zz);
quiver3(fit_center_of_circle(1),fit_center_of_circle(2),fit_center_of_circle(3),normal_vector(1),normal_vector(2),normal_vector(3),1,'R')
set(h, 'FaceAlpha', 0.2, 'MeshStyle', 'none')
axis equal
grid on
plot3(base_circle_point(:,1),base_circle_point(:,2),base_circle_point(:,3),'*');

