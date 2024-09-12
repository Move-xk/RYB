clc
clear

data=[];
% data = load('D:\Workfile\20231103 王marker\10.txt');
% data = [data; load('E:\Scripts\Test_data\楼下数据采集\开灯\曲面与平面Marker\运动\第一次\marker_pose.txt')];
% data = [data; load('E:\Scripts\Test_data\楼下数据采集\开灯\曲面与平面Marker\运动\第二次\marker_pose.txt')];
% data = [data; load('E:\Scripts\Test_data\楼下数据采集\开灯\曲面与平面Marker\运动\第三次\marker_pose.txt')];
% data = [data; load('E:\Scripts\Test_data\楼下数据采集\开灯\曲面与平面Marker\运动\第四次\marker_pose.txt')];
data = [data; load('\\192.168.10.28\1.ryb\2.个人共享\许堃\Marker数据采集\标定板新数据\重复插拔\第五次\marker_pose.txt')];
% data = [data; load('\\192.168.10.28\1.ryb\2.个人共享\许堃\Marker数据采集\Marker 精度对比\第一次\marker_pose.txt')];
% data = [data; load('C:\Users\kk\Desktop\marker_pose.txt')];



% data = [data; load('E:\Scripts\Test_data\楼下数据采集\开灯\超声骨刀标定\右边\第一次\marker_pose.txt')];
% data = [data; load('E:\Scripts\Test_data\楼下数据采集\开灯\超声骨刀标定\右边\第二次\marker_pose.txt')];
% data = [data; load('E:\Scripts\Test_data\楼下数据采集\开灯\超声骨刀标定\右边\第三次\marker_pose.txt')];
% data = [data; load('E:\Scripts\Test_data\楼下数据采集\开灯\超声骨刀标定\右边\第四次\marker_pose.txt')];
% data = [data; load('E:\Scripts\Test_data\楼下数据采集\开灯\超声骨刀标定\右边\第五次\marker_pose.txt')];

% data = [data; load('E:\Scripts\Test_data\楼下数据采集\开灯\16和9Marker精度对比\第一次\marker_pose.txt')];
% data = [data; load('E:\Scripts\Test_data\楼下数据采集\开灯\16和9Marker精度对比\第二次\marker_pose.txt')]; 
% data = [data; load('E:\Scripts\Test_data\楼下数据采集\开灯\16和9Marker精度对比\第三次\marker_pose.txt')]; 
% data = [data; load('E:\Scripts\Test_data\楼下数据采集\开灯\16和9Marker精度对比\第四次\marker_pose.txt')]; 
% data = [data; load('E:\Scripts\Test_data\楼下数据采集\开灯\16和9Marker精度对比\第五次\marker_pose.txt')]; 

 
%% 
% pos_tip = data(:,1:3);  提取文件中对应tip数据
% ori_tip = data(:,4:6);
% pos_base = data(:,7:9);
% ori_base = data(:,10:12);

%% 自研相机-视觉脚本 位置x y z 姿态x y z w
pos_tip= data(:,1:3);
ori_tip(:,1)= data(:,7);
ori_tip(:,2:4)= data(:,4:6);

pos_base = data(:,8:10);
ori_base(:,1)= data(:,14);
ori_base(:,2:4)= data(:,11:13);

%% Tracker采集工具 位置x y z 姿态r p y
% pos_base = data(:,2:4);
% ori_base(:,1) = data(:,7);
% ori_base(:,2) = data(:,6);
% ori_base(:,3) = data(:,5);
% pos_tip = data(:,8:10);
% ori_tip(:,1) = data(:,13);
% ori_tip(:,2) = data(:,12);
% ori_tip(:,3) = data(:,11);

%% 电子面弓采集
% pos_base = data(:,3:5);
% ori_base = data(:,6:9);
% 
% pos_tip = data(:,8:10);
% ori_tip = data(:,11:13);
% 

 num = size(data,1);

for i=1:num
    

    
        ori_tip_m = quat2rotm(ori_tip(i,:));  % 四元数→旋转矩阵
        ori_base_m = quat2rotm(ori_base(i,:));
%         

%         ori_tip_m = eul2rotm(ori_tip(i,:),'zyx');
%         ori_base_m = eul2rotm(ori_base(i,:),'zyx');
        
%         ori_tip_m = rotationVectorToMatrix(ori_tip(i,:))';
%         ori_base_m = rotationVectorToMatrix(ori_base(i,:))';
        
        
% % %         
        
        tip = [ori_tip_m pos_tip(i,:)';0 0 0 1];  %转换为齐次矩阵
        base = [ori_base_m pos_base(i,:)';0 0 0 1];
        

        tcp = inv(tip)*base;
%         tcp = inv(base)*tip;   
%         tcp = tip;
%           tcp = base;
 


    
    
        Xx(i) = tcp(1,1);        Xy(i) = tcp(2,1);           Xz(i) = tcp(3,1);        
        Yx(i) = tcp(1,2);        Yy(i) = tcp(2,2);           Yz(i) = tcp(3,2); 
        Zx(i) = tcp(1,3);        Zy(i) = tcp(2,3);           Zz(i) = tcp(3,3);  %旋转
% %     z = [ tcp(1,3), tcp(2,3),tcp(3,3)];
% %     y = cross(z,[1,0 ,0]);
% %     y = y./norm(y);
% %     x = cross(y,z);
% %     
%         Xx(i) = x(1);        Xy(i) = x(2);           Xz(i) = x(3);        
%         Yx(i) = y(1);        Yy(i) = y(2);           Yz(i) = y(3); 
%         Zx(i) = z(1);        Zy(i) = z(2);           Zz(i) = z(3); 

        
        X(i) = tcp(1,4);         Y(i) = tcp(2,4);         Z(i) = tcp(3,4);  %平移(位置）
        
       ori_data = [ Xx(i),Yx(i),Zx(i);            Xy(i),Yy(i),Zy(i);            Xz(i),Yz(i),Zz(i)];  % 旋转矩阵
                
        ori(i,:) = rotm2quat(ori_data);   %旋转矩阵→四元数
        pos(i,:) = [X(i);Y(i);Z(i)];      % 位置平移的距离
        ori_eul(i,:) = rotm2eul(ori_data); %旋转矩阵→欧拉角
%         pos_rot(i,:)=rad2deg(rotationMatrixToVector(ori_data));   
%         oo1(i,:) = [Xx(i);Xy(i);Xz(i)];
%         oo2(i,:) = [Yx(i);Yy(i);Yz(i)];
%         oo3(i,:) = [Zx(i);Zy(i);Zz(i)];
        
end



x = pos(:,1);
y = pos(:,2);
z = pos(:,3);
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

max_diff_angle=0;
max_pair=[];
for i=1:num
    for j=2:num
        if i==j
            continue
        end
 
         diff_angle_1 = abs(acosd(abs(dot(ori(i,:), ori(j,:)))));   %dot点积、abs绝对值和复数的模、acosd得出来的是度数
         if diff_angle_1>max_diff_angle
             max_diff_angle = diff_angle_1;
             max_pair=[i,j];
         end
    end
end

avg_ori = quat_avg(ori)';
avg_pos = mean(pos);
% RR=norm(avg_pos);
% RR=150;
% tip_error = max_diff_angle*pi*RR/180;
% arr=[max_diff_angle RR tip_error]

DisplayTcpOri(6,zeros(size(X)),zeros(size(X)),zeros(size(X)),Xx,Xy,Xz,Yx,Yy,Yz,Zx,Zy,Zz,1,1)
% DisplayTcpOri(6,X,Y,Z,Xx,Xy,Xz,Yx,Yy,Yz,Zx,Zy,Zz,1,1)


txt = ['max angle' num2cell(max_diff_angle) '（deg)'];
text(0,0,0,txt,'FontSize',20)    %用于定位文本位置与大小

ori_diff_with_avg=[];
pos_diff_with_avg=[];
avg_all=[avg_ori,avg_pos];
for i=1:num
    ori_diff_with_avg(i) = abs(acosd(abs(dot(ori(i,:), avg_ori))));  %向量的点积，再求角度，绝对值
    pos_diff_with_avg(i) = norm(avg_pos-pos(i,:));    %返回向量变量的欧几里德范数。此范数也称为 2-范数、向量模或欧几里德长度。
end
%% 
figure(2)
% clf
hold on
grid on
axis equal
plot3(X,Y,Z,'.')
% avgdcm=quat2dcm(avg_ori);
% plot3(avgdcm(1),avgdcm(2),avgdcm(3),'o')

% vetz=[Zx',Zy',Zz'];
% mvetx = mean(vetx);
% mvetx = mvetx./norm(mvetx);
% plot3(mvetx(1),mvetx(2),mvetx(3),'x')

% mvetz = 0.5*(max(vetz)+min(vetz));
% mvetz = mvetz./norm(mvetz);
% plot3(mvetz(1),mvetz(2),mvetz(3),'x')
% plot3( -0.4771 ,   0.1760 ,  -0.8610,'v')
% plot3( -0.4315,   -0.0676 ,  -0.8996,'v')

% [mvetx, radius] = min_enclosing_sphere(Xx', Xy',Xz', num);
% mvetx = mvetx./norm(mvetx);
% plot3(mvetx(1),mvetx(2),mvetx(3),'x')

%% 
figure(3)
clf
hold on
grid on
yyaxis left
histogram(pos_diff_with_avg, 'Normalization', 'probability')
yyaxis right
histogram(ori_diff_with_avg, 'Normalization', 'probability')
legend('位置误差','姿态误差')

arr=[radius std(pos) norm(std(pos)) std(ori_eul) norm(std(ori_eul))  max_diff_angle  ];  %std标准差
