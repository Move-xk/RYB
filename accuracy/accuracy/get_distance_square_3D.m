%{
Function: get_distance_square_3D
Description: 求空间两点之间距离的平方
Input: 空间两点a，b
Output: 空间两点之间距离的平方
Author: Marc Pony(marc_pony@163.com)
%}
function distanceSquare = get_distance_square_3D(a, b)
distanceSquare = (a(1) - b(1))^2 + (a(2) - b(2))^2 + (a(3) - b(3))^2;
end
