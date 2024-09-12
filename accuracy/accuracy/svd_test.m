clear all;
% close all;
clc;

%生成原始点集
% X=[];Y=[];Z=[];
% for i=-180:2:180
%     for j=-90:2:90
%         x = i * pi / 180.0;
%         y = j * pi / 180.0;
%         X =[X,cos(y) * cos(x)];
%         Y =[Y,sin(y) * cos(x)];
%         Z =[Z,sin(x)];
%     end
% end
% P=[X(1:3000)' Y(1:3000)' Z(1:3000)'];
% 
% %生成变换后点集
% i=0.5;j=0.3;k=0.7;
% Rx=[1 0 0;0 cos(i) -sin(i); 0 sin(i) cos(i)];
% Ry=[cos(j) 0 sin(j);0 1 0;-sin(j) 0 cos(j)];
% Rz=[cos(k) -sin(k) 0;sin(k) cos(k) 0;0 0 1];
% R=Rx*Ry*Rz;
% X=P*R + [0.2,0.3,0.4];
X=[
 -12.5346  13.2779  655.1879  
-44.9164  44.5980  646.4320  
21.0272  46.9080  626.4498  
32.4891  -3.4727  615.2044  
132.6915  3.8549  781.1376  
-143.4517  -67.5101  788.5839  
];

P=[
 439.2994  482.0132  195.0353  
405.5923  454.0397  209.1639  
472.1055  450.4562  226.4833  
486.6809  501.2429  231.3146  
580.0391  466.0369  64.8849  
308.6804  552.4147  56.5253  
];
% plot3(P(:,1),P(:,2),P(:,3),'b.');
% hold on;
% plot3(X(:,1),X(:,2),X(:,3),'r.');

%计算点集均值
up = mean(P);
ux = mean(X);

P1=P-up;
X1=X-ux;

%计算点集协方差
sigma=P1'*X1/(length(X1));

[u s v] = svd(sigma);
RR=u*v';

%计算平移向量
qr=ux-up*RR;

%验证旋转矩阵与平移向量正确性
Pre = P*RR+qr;

figure(1)
clf
hold on
grid on
% plot3(P(:,1),P(:,2),P(:,3),'');
plot3(X(:,1),X(:,2),X(:,3),' o');
plot3(Pre(:,1),Pre(:,2),Pre(:,3),' x');
axis equal


figure(2)
clf
for i=1:6
ax(i)=subplot(3,2,i)
    hold on
    grid on
    plot3(X(i,1),X(i,2),X(i,3),' o');
    plot3(Pre(i,1),Pre(i,2),Pre(i,3),' x');
end
linkaxes(ax,'xy')

for i=1:size(X,1)
    dx = X-Pre;
    norm_dx(i) = norm(dx(i,:));
end
TT=[RR qr';0,0,0,1;]

figure(3)
clf
x1=rand(30,2);
y1=rand(50,2);
% subplot(2,2,1),plot(x1);
% subplot(2,2,2),plot(y1);
% subplot(2,2,3),plot(x1);
% subplot(2,2,4),plot(y1);
t=tiledlayout(2,2,'TileSpacing','Compact','Padding','Compact');
nexttile
plot(x1)
nexttile
plot(y1)
nexttile
plot(x1)
nexttile
plot(y1)

figure(4)
clf
subplot('Position',[0.13,0.56,0.37,0.37]),plot(x1);
subplot('Position',[0.54,0.56,0.37,0.37]),plot(y1);
subplot('Position',[0.13,0.11,0.37,0.37]),plot(x1);
subplot('Position',[0.54,0.11,0.37,0.37]),plot(y1);

