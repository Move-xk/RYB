clc;clear
%文件地址
filename = '20240417_112553_HX2021000877曾焕祝_SaveOperateInfo.txt';
filepath = '\\192.168.10.28\1.ryb\2.个人共享\田飞飞\2024年\2.0 上颌窦手术分析病例\曾焕祝\手术病例\data\';


ff=fullfile(filepath, filename);
if (exist(ff)==0)
    error('文件地址不存在')
end

%打开txt
fid = fopen(ff);
data = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %s %d','headerlines',1);
fclose(fid);

%解析时间的时、分、秒到秒
tt=split(data{1,1},["-",":","."]);
hh=str2num(char(tt(:,4)));
mm=str2num(char(tt(:,5)));
ss=str2num(cell2mat(tt(:,6:7)));
date_time=hh*60*60+mm*60+ss*0.001;

%声明txt里所有变量
x=data{1,2};    y=data{1,3};    z=data{1,4};    rx=data{1,5};   ry=data{1,6};   rz=data{1,7};   pose=[x,y,z,rx,ry,rz]; pos=[x,y,z];
j1=data{1,8};   j2=data{1,9};   j3=data{1,10};  j4=data{1,11};  j5=data{1,12};  j6=data{1,13};  joint=[j1,j2,j3,j4,j5,j6];
fx=data{1,14};  fy=data{1,15};  fz=data{1,16};  fnx=data{1,17}; fny=data{1,18}; fnz=data{1,19};   force=sqrt(fx.*fx+fy.*fy+fz.*fz); forcexy=sqrt(fx.*fx+fy.*fy);
flag=data{1,20};    depth=data{1,21};   mode=data{1,22};    dist=data{1,23};
tx=data{1,24};   ty=data{1,25};   tz=data{1,26};  trx=data{1,27};  tryy=data{1,28};  trz=data{1,29};tpose=[tx,ty,tz,trx,tryy,trz];tpos=[tx,ty,tz];
drill_type=data{1,30};  tooth_num=data{1,31};

%获取牙位号、钻针类型、flage类型种类
[tooth_num_type,tooth_num_index]=unique(tooth_num,'stable');
[drill_type_type,drill_type_index]=unique(drill_type,'stable');
[flag_type,flag_index,flag_n]=unique(flag,'stable');

num = size(date_time,1);
%现有flag类型及其意义
flag_dict={0, '默认';
21, '示教模式';
11, '注册的示教';
5, '工作位/收纳位';
6, '力清零';
4, '机械臂注册';
7, '口外平滑';
17, '口内平滑';
14, '轴向调整（钻针z轴）';
15, '360';
3, '手动下钻';
18, '自动下钻';
29, '点钻';
28, '提拉模式';
19, '骨平面提拉';
10, '校准位';
8, '校准位';
26, '上颌窦内提'};
%搜索txt里都有什么类型
for i=1:size(flag_type,1)
   flag_type_str(i)= flag_dict(find(cell2mat(flag_dict(:,1))==flag_type(i)),2);
end

%%将所有数据打印出来，便于寻找需要的数据，
figure(3)
clf
hold on
grid on
plot(tooth_num)
plot(flag, '.')
% plot(depth)
plot(force-force(1))
% plot(ty-ty(1))
% plot(tz-tz(1))
% plot(ty-ty(1))
% plot(y)
    
%能自动寻找flag和牙位号，但是把所有满足情况的数据都提取，如果有两组数据需要手动分开
aim_index=find( flag==26 ); %29点钻 18一钻到底 26上颌窦内提
% aim_index=find( flag==26 & tooth_num==11); %29点钻 18一钻到底 26上颌窦内提

%如果没有相应index，打印一个not found
if isempty(aim_index)
    disp('not found')
end
[a,m]=unique(drill_type,'stable');
m=[m;size(drill_type,1)];

%% 画力图和患者位置图
%如果前面找到目标index，使用目标index，如果没有可以手输
if isempty(aim_index)
    index=[23695:24315];
else
    index=aim_index;
end
dp = pos(index,:)-pos(index(1),:);
dpn = vecnorm(dp,1,2);
dtp = tpos(index,:)-tpos(index(1),:);
dtpn = vecnorm(dtp,1,2);

figure(10)
clf

%画患者marker数据
tiledlayout('flow','TileSpacing', 'compact','Padding', 'compact')
ax1(1) = nexttile;
    hold on
    grid on
%     plot(date_time(index)-date_time(index(1)),x(index)-x(index(1)),'linewidth',1,'linestyle','-')    %画x线
%     plot(date_time(index)-date_time(index(1)),y(index)-y(index(1)),'linewidth',1,'linestyle','-')    %画y线
%     plot(date_time(index)-date_time(index(1)),z(index)-z(index(1)),'linewidth',1,'linestyle','-')    %画z线
    plot(date_time(index)-date_time(index(1)),depth(index),'linewidth',2)                            %画深度线
    plot(date_time(index)-date_time(index(1)),dpn,'linewidth',2,'linestyle','-')                     %画运动路程线
   
%     plot(date_time(index(2:end))-date_time(index(1)),10*vecnorm(diff(pos(index,:)),1,2))             %画运动变化率，并放大10倍
%      
% 
    ylabel('位置（mm)')
    xlabel('时间（s)')
    subtitle(['患者marker'])
%     legend('x','y','z','模','深度','位置导')
    legend('深度','位移','Location','best','NumColumns',1)
legend('boxoff')

%画TCP位置数据
% ax1(2) = nexttile;    
%     hold on
%     grid on
%     plot(date_time(index)-date_time(index(1)),tx(index)-tx(index(1)),'linewidth',1)
%     plot(date_time(index)-date_time(index(1)),ty(index)-ty(index(1)),'linewidth',1)
%     plot(date_time(index)-date_time(index(1)),tz(index)-tz(index(1)),'linewidth',1)
%     plot(date_time(index)-date_time(index(1)),dtpn,'linewidth',2,'linestyle','-')
%     plot(date_time(index)-date_time(index(1)),depth(index),'linewidth',2)
%     ylabel('位置（mm)')
%     xlabel('时间（s)')
%     subtitle(['机械臂位置'])


%画力数据
ax1(3) = nexttile;    
    hold on
    grid on
%     plot(date_time(index)-date_time(index(1)),fx(index)-fx(index(1)),'linewidth',1)
%     plot(date_time(index)-date_time(index(1)),fy(index)-fy(index(1)),'linewidth',1)
%     plot(date_time(index)-date_time(index(1)),fz(index)-fz(index(1)),'linewidth',1)
    plot(date_time(index)-date_time(index(1)),depth(index),'linewidth',2)
    plot(date_time(index)-date_time(index(1)),force(index),'linewidth',2,'linestyle','-')

    plot(date_time(index)-date_time(index(1)),fz(index),'linewidth',1)
    ylabel('位置（mm) / 力（N)')
    xlabel('时间（s)')
    subtitle(['机械臂受力'])
    legend('深度','合力','Z向力','Location','best','NumColumns',1)
    legend('boxoff')

    %对齐横坐标
linkaxes(ax1,'x')
