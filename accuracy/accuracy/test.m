%% https://zhuanlan.zhihu.com/p/97036816

% clear all
%确认圆心和半径
% o = [13.85 23.45 8.94];
% R = mean(o);
% %获得一系列测量点
% P = [];
% nP = [];
% for i = 1:100
%     vec = [randn(1,1) randn(1,1) randn(1,1)];
%     vec = vec/norm(vec) + 0.01*[randn(1,1) randn(1,1) randn(1,1)];
%     P   = [ P; o+R*vec; ];
%     nP  = [nP;norm(P(i,:)-o)];
% end
P=pos(:,1:3);

%由P生成A（包括Ax，Ay，Az，Ad）和e
 x = P(:,1);
 y = P(:,2);
 z = P(:,3);
Ax = -2*x;
Ay = -2*y;
Az = -2*z;
Ad =  0*P(:,1) + 1;
 A = [ Ax Ay Az Ad];
 e = -x.^2 -y.^2 -z.^2;
%求解abcd, Ax=e
 X = inv(A'*A)*A'*e;
 a = X(1)
 b = X(2)
 c = X(3)
 r2 = a^2 + b^2 + c^2 - X(4)
 r  = r2^0.5
%验证结果
% err = [a b c r] - [ o R] %结果接近0，说明结果正确
%绘图验证
figure(1)
% clf
hold on
plot3(P(:,1),P(:,2),P(:,3),'.')
% plot3(o(1),o(2),o(3),'o')
plot3(a,b,c,'*')
grid on
axis equal