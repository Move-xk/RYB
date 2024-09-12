%{
Function: get_circle_center_3D
Description: 求空间三点确定的圆周的圆心
Input: 空间三个点a,b,c
Output: 空间圆周圆心center
Author: Marc Pony(marc_pony@163.com)
%}
function center = get_circle_center_3D(a, b, c)
x1 = a(1);
y1 = a(2);
z1 = a(3);
x2 = b(1);
y2 = b(2);
z2 = b(3);
x3 = c(1);
y3 = c(2);
z3 = c(3);
x4 = 0.5 * (x1 + x2);
y4 = 0.5 * (y1 + y2);
z4 = 0.5 * (z1 + z2);

x5 = 0.5 * (x2 + x3);
y5 = 0.5 * (y2 + y3);
z5 = 0.5 * (z2 + z3);

a11 = x2 - x1;
a12 = y2 - y1;
a13 = z2 - z1;
b1 = x4 * a11 + y4 * a12 + z4 * a13;

a21 = x3 - x2;
a22 = y3 - y2;
a23 = z3 - z2;
b2 = x5 * a21 + y5 * a22 + z5 * a23;

a31 = (y1 - y2) * (z2 - z3) - (y2 - y3) * (z1 - z2);
a32 = (x2 - x3) * (z1 - z2) - (x1 - x2) * (z2 - z3);
a33 = (x1 - x2) * (y2 - y3) - (x2 - x3) * (y1 - y2);
b3 = x3 * a31 + y3 * a32 + z3 * a33;

center = zeros(3, 1);
temp = a11 * (a22 * a33 - a23 * a32) + a12 * (a23 * a31 - a21 * a33) + a13 * (a21 * a32 - a22 * a31);
center(1) = ((a12 * a23 - a13 * a22) * b3 + (a13 * a32 - a12 * a33) * b2 + (a22 * a33 - a23 * a32) * b1) / temp;
center(2) = -((a11 * a23 - a13 * a21) * b3 + (a13 * a31 - a11 * a33) * b2 + (a21 * a33 - a23 * a31) * b1) / temp;
center(3) = ((a11 * a22 - a12 * a21) * b3 + (a12 * a31 - a11 * a32) * b2 + (a21 * a32 - a22 * a31) * b1) / temp;
end
