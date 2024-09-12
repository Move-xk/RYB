% Q is an Nx4 matrix of quaternions. weights is an Nx1 vector, a weight for each quaternion.
% Qavg is the weightedaverage quaternion

% Markley, F. Landis, Yang Cheng, John Lucas Crassidis, and Yaakov Oshman. 
% "Averaging quaternions." Journal of Guidance, Control, and Dynamics 30, 
% no. 4 (2007): 1193-1197.

function [Qavg] = quat_avg(Q)

% Form the symmetric accumulator matrix
M = zeros(4, 4);
n = size(Q, 1);   % amount of quaternions
wSum = 0;
weights = ones(n,1) / n;
for i = 1:n
    q = Q(i,:)';
    w_i = weights(i);
    M = M + w_i.*(q*q');
    wSum = wSum + w_i;
end

% scale
M = (1.0/wSum)*M;

% The average quaternion is the eigenvector of M corresponding to the maximum eigenvalue. 
% Get the eigenvector corresponding to largest eigen value
[Qavg, ~] = eigs(M, 1);

end