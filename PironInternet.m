clc 
clearvars
close all

% Load the mass, stiffness, and modeshape matrices from a .mat file
% load('cantilever_beam.mat');

% Define the mass and stiffness matrices
m1 = 1; m2 = 2; m3 = 3; m4 = 4;
k1 = 1; k2 = 2; k3 = 3; k4 = 4;
M = [m1 0 0 0; 0 m2 0 0; 0 0 m3 0; 0 0 0 m4];
K = [k1 -k1 0 0; -k1 k1+k2 -k2 0; 0 -k2 k2+k3 -k3; 0 0 -k3 k3+k4];


% Compute the natural frequencies and damping ratios
[eigenvectors, eigenvalues] = eig(K,M);
wn = sqrt(diag(eigenvalues));
zeta = -real(diag(eigenvalues))./abs(diag(eigenvalues));

% Select the number of modes to include in the model
num_modes = 4;

% Use the first num_modes modeshapes to form the modeshape matrix C
C = [eigenvectors(:,1:num_modes)',zeros(num_modes)];

% Define the state-space model of the system
A = [zeros(num_modes), eye(num_modes); -diag(wn.^2), -diag(2*zeta.*wn)];
B = [zeros(num_modes,num_modes); M\eye(num_modes)];
D = zeros(size(C,1),size(B,2));
sys = ss(A,B,C,D);

% Convert the state-space model to a transfer function
G = tf(sys);

syms s
% Define the weighting function for the sensitivity
W1 = 1/s;

% Define the weighting function for the control effort
W2 = 1/s;

% Compute the pole-zero cancellation matrix
% [num,den] = tfdata(G);
% poles = roots(cell2mat(den));
% zeros = roots(cell2mat(num));
% Kcancel = diag(ones(size(poles))) + diag(poles)*inv(diag(zeros))*diag(ones(size(zeros)));

% Compute the H-infinity optimal sensor-actuator pair
% [K,CL,gamma] = hinfsyn(G,1,1,'method','ric','w1',W1,'w2',W2,'A',A);

% Compute the optimal sensor-actuator placement
[L,~] = place(A',C',[-2,-3,-4,-5,-6,-7,-8,-9]);

% Display the results
disp('Optimal sensor-actuator placement:');
disp(L');
disp('H-infinity optimal controller gain:');
disp(K);
