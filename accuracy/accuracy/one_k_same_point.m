clc
clear
% close all

a = load('D:\data\oo.txt');

num=size(a,1);
for i=1:num
    mi = angle2dcm(a(i,4),a(i,5),a(i,6));
    an(i) =acosd(mi(3,3));
end
figure(2)
histogram(an-mean(an))

