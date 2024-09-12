% o1=[33.841 0.1833 253.516 0.6383 -1.4223 -0.6548];
% o6=[-67.2949 19.1791 149.4085 1.6804 -1.0516 2.2876];

o1=[33.9268 0.2483 253.5631 1.6804 -1.0516 2.2876];
o6=[-71.0151 18.6677 150.3596 1.6777 -0.9222 2.2097];
% qa = axisa2quat(1.75912424830947,  -1.74434453577554 , -0.02018587581977);

qa = axisa2quat(o1(1,4),o1(1,5),o1(1,6));
qb = axisa2quat(o6(1,4),o6(1,5),o6(1,6));
% qa=[-0.06066800, -0.13985632, -0.26815555, 0.95123720];
% qb=[-0.31047114, -0.05848166, 0.08438845, 0.94502178];
% 
[a1,b1,c1]=quat2angle(qa,'zyx');
[a2,b2,c2]=quat2angle(qb,'zyx');

% axisa2dcm(o1(1,4),o1(1,5),o1(1,6))
% quat2dcm(qa)


% [a2,b2,c2]=dcm2angle(axisa2dcm(o1(1,4),o1(1,5),o1(1,6)),'zyx')
% [a2,b2,c2]=dcm2angle(quat2dcm(qa),'zyx')
% trplot(quat2dcm(qa))
% hold on
% trplot(quat2dcm(qb))
% hold on

dtcp = norm(o1(1,1:3)-o6(1,1:3));
dori= (acosd(abs(dot(qa,qb))));

ma=quat2dcm(qa);
mb=quat2dcm(qb);

rab=inv(ma)*mb;
acosd(rab(3,3))

acosd(ma(3,3));
acosd(mb(3,3));

fa = [ma,o1(1,1:3)';0,0,0,1];
fb = [mb,o6(1,1:3)';0,0,0,1];

maz=ma(1:3,3);
mbz=mb(1:3,3);

% maz=o1(1,4:6);
% mbz=o6(1,4:6);

acosd(dot(maz,mbz)/(norm(maz)*norm(mbz)))

% figure(1)
% clf
% trplot(ma)
% hold on
% trplot(mb)
%  trplot(fa)
% hold on
% trplot(fb)
% hold off


% dori= 2*(acosd(abs(dot(qa,qb))))

