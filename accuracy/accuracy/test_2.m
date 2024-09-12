clc
clf
A = [-59.0561 0.0616951 18.8272; -61.5553 8.0346 23.9405; -56.617 11.5031 39.7509;-47.1173 7.18897 40.8822; -67.7057 -7.17927 31.1862; -65.8634 3.82451 36.2679;
    -61.6635 -3.17824 44.9511]
B = [-59.0488 0.104715 18.7616;-61.5694 8.05897 23.9404; -56.6708 11.5307 39.7246; -47.1707 7.2083 40.9227; -67.7224 -7.15831 31.2284; -65.8685 3.89872 36.3207; 
    -61.7262 -3.15287 44.946]

Xi = A(:,1)
Yi = A(:,2)
Zi = A(:,3)
Xj = B(:,1)
Yj = B(:,2)
Zj = B(:,3)
plot3(Xi,Yi,Zi,'-o','Color','b','MarkerSize',10,'MarkerFaceColor','#D9FFFF')
hold on 
grid on
plot3(Xj,Yj,Zj,'-o','Color','r','MarkerSize',10,'MarkerFaceColor','#D9FFFF')

distances = sqrt((Xi-Xj).^2 + (Yi-Yj).^2 + (Zi-Zj).^2);

% 绘制图表2
figure(2)
bar(distances)
for i = 1:length(distances)
    text(i, distances(i), num2str(distances(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
end
xlabel('Point Pairs')
ylabel('Distance')
title('Distance between Points')
grid on

% 设置x轴刻度
xticks(1:7)
xticklabels({'1-8', '2-9', '3-10', '4-11', '5-12', '6-13', '7-14'})