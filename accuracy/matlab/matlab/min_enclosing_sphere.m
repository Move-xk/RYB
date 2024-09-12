%{
Function: min_enclosing_sphere
Description: 求三维空间pointCount个点的最小包围球
Input: 空间pointCount个点的坐标(x,y,z)，点个数pointCount
Output: 空间pointCount个点的最小包围球球心sphereCenter，半径radius
Author: Marc Pony(marc_pony@163.com)
%}
function [sphereCenter, radius] = min_enclosing_sphere(x, y, z, pointCount)
p = [x(:)'; y(:)'; z(:)'];
% p = p(:, randperm(pointCount)); %随机打乱数据
sphereCenter = p(:, 1);
radiusSquare = 0.0;
for i = 2 : pointCount
    if get_sign(get_distance_square_3D(p(:, i), sphereCenter) - radiusSquare) > 0
        sphereCenter = p(:, i);
        radiusSquare = 0.0;
        for j = 1 : i
            if get_sign(get_distance_square_3D(p(:, j), sphereCenter) - radiusSquare) > 0
                sphereCenter = 0.5 * (p(:, i) + p(:, j));
                radiusSquare = get_distance_square_3D(p(:, j), sphereCenter);
                for k = 1 : j
                    if get_sign(get_distance_square_3D(p(:, k), sphereCenter) - radiusSquare) > 0
                        sphereCenter = get_circle_center_3D(p(:, i), p(:, j), p(:, k));
                        radiusSquare = get_distance_square_3D(p(:, i), sphereCenter);
                        for m = 1 : k
                            if get_sign(get_distance_square_3D(p(:, m), sphereCenter) - radiusSquare) > 0
                                sphereCenter = get_sphere_center(p(:, i), p(:, j), p(:, k), p(:, m));
                                radiusSquare = get_distance_square_3D(p(:, i), sphereCenter);
                            end
                        end
                    end
                end
            end
        end
    end
end
radius = sqrt(radiusSquare);
end
