function [x,y,z,angle] = axisangle2quat(qw,qx,qy,qz)


angle = 2 * acos(qw);
x = qx / sqrt(1-qw*qw);
y = qy / sqrt(1-qw*qw);
z = qz / sqrt(1-qw*qw);
end