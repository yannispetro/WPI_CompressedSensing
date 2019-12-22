
% % Create dictionary by deleting rows of a random square matrix
A = create_A(n,p);
load('signal_1')
y = A*x0;

% Preprocess data
X = normalize(A);
y = center(y);

x_hat = OMP(k,y.',A);