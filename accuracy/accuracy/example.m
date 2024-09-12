clc
clear
close all

for pointCount = [2, 3, 100, 1000]
    phi = pi * rand(pointCount, 1);
    theta = 2 * pi * rand(pointCount, 1);
    R = 100 * rand(pointCount, 1);
    
    x = R .* sin(phi) .* cos(theta);
    y = R .* sin(phi) .* sin(theta);
    z = R .* cos(phi);
    [sphereCenter, radius] = min_enclosing_sphere(x, y, z, pointCount);
    
    figure('color', 'w')
    draw_sphere(sphereCenter, radius)
    hold on
    plot3(x, y, z, 'r+')
    axis equal tight
    
    if sum(sqrt((x - sphereCenter(1)).^2 + (y - sphereCenter(2)).^2 + (z - sphereCenter(3)).^2) > radius + 0.0001) > 0
       disp('至少有一个点在球面以外')
    end
end
