clc
clear

o1 = load('D:\data\1\o1.txt');
o6 = load('D:\data\1\o6.txt');
angle=0.5*norm(o1(1,4:6));
qa = [cos(angle),o1(1,4)*sin(0.5*angle)/angle,o1(1,5)*sin(0.5*angle)/angle,o1(1,6)*sin(0.5*angle)/angle];
qa=qa./norm(qa);
for i=1:size(o1,1)
    dtcp(i) = norm(o1(1,1:3)-o1(i,1:3));
    
    angle=0.5*norm(o1(1,4:6));
    qi = [cos(angle),o1(i,4)*sin(0.5*angle)/angle,o1(i,5)*sin(0.5*angle)/angle,o1(i,6)*sin(0.5*angle)/angle];
     qi=qi./norm(qi);
%     angle2qurt(o1(1,4:6)
    dori(i)= (acosd(abs(dot(qa,qi))));
    
    acos(abs(dot(qa,qa)));
    
    
    ndo(i) = norm(o1(i,1:3)-o6(i,1:3));
end
figure(1)
plot(dtcp,ndo,'. -');
grid on

figure(2)
plot(dori,ndo,'.');
grid on

figure(3)
clf
plot3(o1(:,1),o1(:,2),o1(:,3),'. -');
hold on
plot3(o6(:,1),o6(:,2),o6(:,3),'. -');
axis equal
grid on
