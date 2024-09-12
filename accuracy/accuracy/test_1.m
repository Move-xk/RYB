clc
clf
x=[1:8]
y=[10,9,22,35,18,30,25,20]
subplot(2,2,1)
area(y)
hold on 
bar(x,y)
hold on
plot(x,y,'LineWidth',2,'Color','r','LineStyle','--')
hold off

x = [10 25 50 15]
explode = [0 1 1 0]
subplot(2,2,2)
pie(x,explode)
colormap winter

y = [10 6 17 13 20 15 25]
e = [2 1.5 1 3 1 2 1.6]
subplot(2,2,3)
errorbar(y,e)

x = [1:100]
y = rand(size(x))
subplot(2,2,4)
scatter(x,y)

yn = randn(10000,3)
figure(2)
histogram(yn)

theta = 0:0.01:2*pi;
rho = sin(2*theta).*cos(2*theta);
polarplot(theta,rho) 

t = 0:pi/50:10*pi
figure(3)
plot3(sin(t),cos(t),t)
axis square;grid on

[X,Y] = meshgrid(-1:.125:3)
Z = peaks(X,Y)
figure(4)
meshc(X,Y,Z)
colormap colorcube
axis([-3 3 -3 3 -10 10])

X1 = [1 20]
Y1 = [1 30]
figure(5)
line(X1,Y1,'LineStyle','-.')
