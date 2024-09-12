%{
Function: get_sphere_center
Description: 求四面体外接球的球心
Input: 空间不共面四个点A,B,C,D
Output: 球面球心sphereCenter
Author: Marc Pony(marc_pony@163.com)
%}
function sphereCenter = get_sphere_center(A, B, C, D)
x1 = A(1);
y1 = A(2);
z1 = A(3);
x2 = B(1);
y2 = B(2);
z2 = B(3);
x3 = C(1);
y3 = C(2);
z3 = C(3);
x4 = D(1);
y4 = D(2);
z4 = D(3);

a11 = x2 - x1;
a12 = y2 - y1;
a13 = z2 - z1;
b1 = 0.5 * ((x2 - x1) * (x2 + x1) + (y2 - y1) * (y2 + y1) + (z2 - z1) * (z2 + z1));

a21 = x3 - x1;
a22 = y3 - y1;
a23 = z3 - z1;
b2 = 0.5 * ((x3 - x1) * (x3 + x1) + (y3 - y1) * (y3 + y1) + (z3 - z1) * (z3 + z1));

a31 = x4 - x1;
a32 = y4 - y1;
a33 = z4 - z1;
b3 = 0.5 * ((x4 - x1) * (x4 + x1) + (y4 - y1) * (y4 + y1) + (z4 - z1) * (z4 + z1));

temp = a11 * (a22 * a33 - a23 * a32) + a12 * (a23 * a31 - a21 * a33) + a13 * (a21 * a32 - a22 * a31);
x0 = ((a12 * a23 - a13 * a22) * b3 + (a13 * a32 - a12 * a33) * b2 + (a22 * a33 - a23 * a32) * b1) / temp;
y0 = -((a11 * a23 - a13 * a21) * b3 + (a13 * a31 - a11 * a33) * b2 + (a21 * a33 - a23 * a31) * b1) / temp;
z0 = ((a11 * a22 - a12 * a21) * b3 + (a12 * a31 - a11 * a32) * b2 + (a21 * a32 - a22 * a31) * b1) / temp;
sphereCenter = [x0; y0; z0];
end
