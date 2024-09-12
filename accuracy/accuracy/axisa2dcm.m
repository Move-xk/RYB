function dcm = axisa2dcm(rx,ry,rz)
    angle = sqrt(rx * rx + ry * ry + rz * rz);
    kx=rx/angle;
    ky=ry/angle;
    kz=rz/angle;

    dcm = zeros(3,3);
    dcm(1, 1) = cos(angle) + kx * kx * (1 - cos(angle));
    dcm(2, 1) = kx * ky * (1 - cos(angle)) - kz * sin(angle);
    dcm(3, 1) = ky * sin(angle) + kx * kz * (1 - cos(angle));

    dcm(1, 2) = kz * sin(angle) + kx * ky * (1 - cos(angle));
    dcm(2, 2) = cos(angle) + ky * ky * (1 - cos(angle));
    dcm(3, 2) = -kx * sin(angle) + ky * kz * (1 - cos(angle));

    dcm(1, 3) = -ky * sin(angle) + kx * kz * (1 - cos(angle));
    dcm(2, 3) = kx * sin(angle) + ky * kz * (1 - cos(angle));
    dcm(3, 3) = cos(angle) + kz * kz * (1 - cos(angle));
end