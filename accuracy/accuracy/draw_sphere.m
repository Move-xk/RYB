%{
Function: draw_sphere
Description: 画球面
Input: 球心sphereCenter，球半径radius
Output: 无
Author: Marc Pony(marc_pony@163.com)
%}
function draw_sphere(sphereCenter, radius)
[x,y,z] = sphere(200);
x = x * radius + sphereCenter(1);
y = y * radius + sphereCenter(2);
z = z * radius + sphereCenter(3);
h = surf(x, y, z);
xlabel('x')
ylabel('y')
zlabel('z')
set(h, 'FaceAlpha', 0.3, 'MarkerEdgeColor', 'none')
shading interp
end
