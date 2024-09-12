function [ center, r, fittingError ] = sphere_fitting( points, pointCount, crossStartAndEndPointFlag )
%{
Function: sphere_fitting
Description: 球面拟合
Input: 三维点points, 点个数pointCount, 是否经过起点/终点标志位crossStartAndEndPointFlag
Output: 球心center, 半径r, 拟合误差fittingError
Author: Marc Pony(marc_pony@163.com)
球面方程:(x - a)^2 + (y - b)^2  + (z - c)^2 = r^2  ->  -2*x*a - 2*y*b - 2*z*c +
         1*(a^2 + b^2 + c^2 - r^2) = -x^2 - y^2 - z^2
%}
if crossStartAndEndPointFlag == 0
    x = points(:, 1);
    y = points(:, 2);
    z = points(:, 3);
    A = [-2 * x, -2 * y, -2 * z, ones(size(x))];
    B = -x.^2 - y.^2 - z.^2;
    temp = A \ B;
    
    a = temp(1);
    b = temp(2);
    c = temp(3);
    d = temp(4);
else
    x0 = points(1, 1);
    y0 = points(1, 2);
    z0 = points(1, 3);
    xn = points(pointCount, 1);
    yn = points(pointCount, 2);
    zn = points(pointCount, 3);
    x = points(2 : pointCount - 1, 1);
    y = points(2 : pointCount - 1, 2);
    z = points(2 : pointCount - 1, 3);
    EPS = 1.0e-4;

    if abs(x0 - xn) < EPS && abs(y0 - yn) < EPS && abs(z0 - zn) < EPS %起点与终点重合
        A = [2 * (x0 - x), 2 * (y0 - y), 2 * (z0 - z)];
        B = x0^2 + y0^2 + z0^2 - x.^2 - y.^2 - z.^2 ;
        temp = A \ B;
        a = temp(1);
        b = temp(2);
        c = temp(3);
        d = -x0^2 - y0^2 - z0^2 + 2.0 * a * x0 + 2.0 * b * y0 + 2.0 * c * z0;
    else
        if abs(x0 - xn) > EPS
            A = [2 * x * (y0 - yn) / (x0 - xn) - 2 * y - 2 * (xn * y0 - x0 * yn) / (x0 - xn), 2 * x * (z0 - zn) / (x0 - xn) - 2 * z - 2 * (xn * z0 - x0 * zn) / (x0 - xn)];
            B = -x.^2 - y.^2 - z.^2 - x * (xn^2 + yn^2 + zn^2 - x0^2 - y0^2 - z0^2) / (x0 - xn) + (x0 * (xn^2 + yn^2 + zn^2) - xn * (x0^2 + y0^2 + z0^2)) / (x0 - xn);
            temp = A \ B;
            b = temp(1);
            c = temp(2);
            P = -x0^2 - y0^2 - z0^2 + 2 * y0 * b + 2 * z0 * c;
            Q = -xn^2 - yn^2 - zn^2 + 2 * yn * b + 2 * zn * c;
            a = -(P - Q) / (2 * (x0 - xn));
            d = -(P * xn - Q * x0) / (x0 - xn);
        elseif abs(y0 - yn) > EPS
            A = [2 * y * (x0 - xn) / (y0 - yn) - 2 * x - 2 * (yn * x0 - y0 * xn) / (y0 - yn), 2 * y * (z0 - zn) / (y0 - yn) - 2 * z - 2 * (yn * z0 - y0 * zn) / (y0 - yn)];
            B = -y.^2 - x.^2 - z.^2 - y * (yn^2 + xn^2 + zn^2 - y0^2 - x0^2 - z0^2) / (y0 - yn) + (y0 * (yn^2 + xn^2 + zn^2) - yn * (y0^2 + x0^2 + z0^2)) / (y0 - yn);
            temp = A \ B;
            a = temp(1);
            c = temp(2);
            P = -y0^2 - x0^2 - z0^2 + 2 * x0 * a + 2 * z0 * c;
            Q = -yn^2 - xn^2 - zn^2 + 2 * xn * a + 2 * zn * c;
            b = -(P - Q) / (2 * (y0 - yn));
            d = -(P * yn - Q * y0) / (y0 - yn);
        else
            A = [2 * z * (y0 - yn) / (z0 - zn) - 2 * y - 2 * (zn * y0 - z0 * yn) / (z0 - zn), 2 * z * (x0 - xn) / (z0 - zn) - 2 * x - 2 * (zn * x0 - z0 * xn) / (z0 - zn)];
            B = -z.^2 - y.^2 - x.^2 - z * (zn^2 + yn^2 + xn^2 - z0^2 - y0^2 - x0^2) / (z0 - zn) + (z0 * (zn^2 + yn^2 + xn^2) - zn * (z0^2 + y0^2 + x0^2)) / (z0 - zn);
            temp = A \ B;
            b = temp(1);
            a = temp(2);
            P = -z0^2 - y0^2 - x0^2 + 2 * y0 * b + 2 * x0 * a;
            Q = -zn^2 - yn^2 - xn^2 + 2 * yn * b + 2 * xn * a;
            c = -(P - Q) / (2 * (z0 - zn));
            d = -(P * zn - Q * z0) / (z0 - zn);
        end
    end
end

r = sqrt(a^2 + b^2 + c^2 - d);
center(1) = a;
center(2) = b;
center(3) = c;
fittingError = sqrt((points(:, 1) - center(1)).^2 + (points(:, 2) - center(2)).^2+ (points(:, 3) - center(3)).^2) - r;

end
