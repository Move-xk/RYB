function qa = axisa2quat(rx,ry,rz)
    angle = sqrt(rx * rx + ry * ry + rz * rz);
    kx=rx/angle;
    ky=ry/angle;
    kz=rz/angle;

    qw=cos(angle/2);
    qx=kx*sin(angle/2);
    qy=ky*sin(angle/2);
    qz=kz*sin(angle/2);

    qa = [qw,qx,qy,qz];
    qa = qa./norm(qa);
end