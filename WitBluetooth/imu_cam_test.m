clc
clear

t_diff=-6;

fid1 = fopen('E:\data\MT poses 03-01-48.txt');
dd1 = textscan(fid1,'%f %f %f %f %f','headerlines',1  );
fclose(fid1);

fid2 = fopen('E:\data\231114150113.txt');
dd2 = textscan(fid2,'%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','headerlines',2  );
fclose(fid2);

cam_t=dd1{1,2};
cam_x=dd1{1,3};
cam_y=dd1{1,4};
cam_z=dd1{1,5};
cam_p=[cam_x,cam_y,cam_z];
cam_s=vecnorm(cam_p-cam_p(1,:),1,2);

tt=split(dd2{1,2},["-",":","."]);
hh=str2num(char(tt(:,1)));
mm=str2num(char(tt(:,2)));
ss=str2num(cell2mat(tt(:,3:4)));
imu_t=hh*60*60+mm*60+ss*0.001;
imu_x=dd2{1,3};
imu_y=dd2{1,4};
imu_z=dd2{1,5};
imu_p=[imu_x,imu_y,imu_z];
imu_s=vecnorm(imu_p-imu_p(1,:),1,2);

figure(1)
clf
hold on
grid on
yyaxis left
ylabel('相机位移的二阶导','FontSize',10,'FontWeight','bold')
plot(t_diff+cam_t(1:end-2)-cam_t(1),diff(cam_s,2))
yyaxis right
plot(imu_t-imu_t(1),imu_s*9.8)

xlabel('Time(s)','FontSize',10,'FontWeight','bold')
ylabel('加速度的模','FontSize',10,'FontWeight','bold')
legend('cam','imu')
