clc;clear


% data = load("\\192.168.10.28\1.ryb\2.个人共享\许堃\Marker数据采集\标定板新数据\新建文件夹\x_Refine_x_code_233_2411.txt");
data = load('C:\Users\kk\Desktop\MT poses 04-43-46.txt');
% data = load("\\192.168.10.28\1.ryb\2.个人共享\许堃\Marker数据采集\标定板新数据\重复插拔\第一次\marker_pose.txt");


%计算tooltip点的精度&骨叉的重复性精度
pos_tip = data(:,2:4); 	
o = pos_tip(:,1);  r = pos_tip(:,2);  l = pos_tip(:,3);
num = size(pos_tip,1);


%计算标定骨叉的重复性精度
% pos_tip = data(:,2:4); 	
% o = pos_tip(:,1);  r = pos_tip(:,2);  l = pos_tip(:,3);
% pos_base = data(:,8:10);    
% x = pos_base(:,1);  y = pos_base(:,2);  z = pos_base(:,3);
% 
% ori_tip = data(:,4:7);
% ori_base = data(:,5:8);
% 
% num = size(pos_tip,1);
% max_error = 0;


% for i=1:num
%     ori_tip_m = quat2rotm(ori_tip(i,:));  % 四元数→旋转矩阵
%     ori_base_m = quat2rotm(ori_base(i,:));
%     
%     tip = [ori_tip_m pos_tip(i,:)';0 0 0 1];  %转换为齐次矩阵
%     base = [ori_base_m pos_base(i,:)';0 0 0 1];
%         
%     tcp = inv(tip)*base;
% %    tcp = inv(base)*tip;   
% %    tcp = tip;
% %    tcp = base;
%  
%   
%     
%         Xx(i) = tcp(1,1);        Xy(i) = tcp(2,1);           Xz(i) = tcp(3,1);        
%         Yx(i) = tcp(1,2);        Yy(i) = tcp(2,2);           Yz(i) = tcp(3,2); 
%         Zx(i) = tcp(1,3);        Zy(i) = tcp(2,3);           Zz(i) = tcp(3,3);  %旋转     
%         X(i) = tcp(1,4);         Y(i) = tcp(2,4);            Z(i) = tcp(3,4);  %平移(位置）
%         
%        ori_data = [ Xx(i),Yx(i),Zx(i);            Xy(i),Yy(i),Zy(i);            Xz(i),Yz(i),Zz(i)];  % 旋转矩阵
%                 
%         ori(i,:) = rotm2quat(ori_data);   %旋转矩阵→四元数
%         pos(i,:) = [X(i);Y(i);Z(i)];      % 位置平移的距离
%         ori_eul(i,:) = rotm2eul(ori_data); %旋转矩阵→欧拉角      
% end


% for i = 1:num
%     x1 = pos_tip(i,1);  y1 = pos_tip(i,2);  z1 = pos_tip(i,3);
%     x2 = pos_base(i,2);  y2 = pos_base(i,2);  z2 = pos_base(i,3);
%     error = sqrt((x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2);
%     if error >= max_error
%         max_error = error;
%     end
% end

%计算tooltip点的误差、方差、标准差&标定板误差
avg_o = mean(o);   avg_r = mean(r);   avg_l = mean(l);
var_o = var(o);    var_r = var(r);    var_l = var(l);
std_o = std(o);    std_r = var(r);    std_l = var(l);

%计算每个坐标点的误差、方差、标准差
% avg_x = mean(x);   avg_y = mean(y);   avg_z = mean(z);
% avg_o = mean(o);   avg_r = mean(r);   avg_l = mean(l);
% 
% var_x = var(x);    var_y = var(y);    var_z = var(z);
% var_o = var(o);    var_r = var(r);    var_l = var(l);
% 
% std_x = std(x);    std_y = var(y);    std_z = var(z);
% std_o = std(o);    std_r = var(r);    std_l = var(l);

avg_pos = mean(pos_tip);
ori_diff_with_avg = [];
pos_diff_with_avg = [];
pos_diff_with_avg_x = [];
pos_diff_with_avg_y = [];
pos_diff_with_avg_z = [];
% avg_ori = quat_avg(ori)';

num = size(pos_tip,1);
for i=1:num
%       ori_diff_with_avg(i) = abs(acosd(abs(dot(ori(i,:), avg_ori))));  %向量的点积，再求角度，绝对值
      pos_diff_with_avg(i) = norm(avg_pos-pos_tip(i,:));    %返回向量变量的欧几里德范数。此范数也称为 2-范数、向量模或欧几里德长度。
      pos_diff_with_avg_x(i) = abs(avg_o - o(i,:));
      pos_diff_with_avg_y(i) = abs(avg_r - r(i,:));
      pos_diff_with_avg_z(i) = abs(avg_l - l(i,:));
end


%绘制姿态与位置误差
% figure(2)
% clf
% hold on 
% grid on
% yyaxis left
% histogram(pos_diff_with_avg, 'Normalization', 'probability')
% yyaxis right
% histogram(ori_diff_with_avg, 'Normalization', 'probability')
% legend('位置误差','姿态误差')

% 绘制坐标与坐标之间的误差
clf
subplot(2,2,1);
hold on
grid on
plot(pos_diff_with_avg,"+");
legend("坐标误差")

subplot(2,2,2);
hold on 
grid on
plot(pos_diff_with_avg_x,"+");
legend("X方向误差")

subplot(2,2,3);
hold on 
grid on
plot(pos_diff_with_avg_y,"+");
legend("Y方向误差")

subplot(2,2,4);
hold on 
grid on
plot(pos_diff_with_avg_z,"+");
legend("Z方向误差")

%绘制标定板的包络图
% [sphereCenter, radius] = min_enclosing_sphere(x, y, z, num);
% ac=sphereCenter;
% figure(1)
% clf
% draw_sphere(sphereCenter, radius)
% hold on
% grid on
% plot3(x, y, z, 'r+')
% plot3(sphereCenter(1),sphereCenter(2),sphereCenter(3),'bo')
% txt = ['R' num2cell(radius) '(mm)'];
% text(sphereCenter(1)+radius,sphereCenter(2),sphereCenter(3),txt,'FontSize',20)
% axis equal tight
% if sum(sqrt((x - sphereCenter(1)).^2 + (y - sphereCenter(2)).^2 + (z - sphereCenter(3)).^2) > radius + 0.0001) > 0
%    disp('至少有一个点在球面以外')
% end

