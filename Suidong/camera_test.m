clc;
clear;

camera_data = load('\\192.168.10.28\1.ryb\2.个人共享\许堃\RD200\RT300C跟踪仪标定\lvbo\导轨移动\MT-MU-10data1-lvbo-关闭.txt');
daogui_data = csvread('\\192.168.10.28\1.ryb\2.个人共享\许堃\RD200\ServoStudioScopeData-1.csv');
x = camera_data(:,2); y = camera_data(:,3); z = camera_data(:,4); qw = camera_data(:,5); qx = camera_data(:,6); qy = camera_data(:,7); qz = camera_data(:,8);


figure(1);
grid on;
hold on;
plot(x);
