clc
clear all
close all

m = 100; % Define number of obdervations

load('signals3/signal_6.mat')
% load('signal_20.mat')

n = length(x0);        % length of signal
ng_perm = 1; % floor(n/10); % number of groups
ng = n + ng_perm;      % size of B (all sets) cell matrix


% % % Create dictionary by deleting rows of the monomial basis
% num = 5;
% dof = 3;
% x_max = 1.0;
% D = Create_monomial_basis(num,dof,x_max);
% [phi, locations] = delete_rows(n, m);
% A = phi * D;

% % Create random dictionary
% A = randn( m, n );


% Compute the observations
% y = A*x0;

% % Create dictionary by deleting rows of an n x n random matrix
A = create_A(n,m);

% Compute the observations
y = A*x0;

% % % Preprocess data
[A,normAi] = normalize(A);
% y = center(y);

% % Define block set BB
% BB = cell(ng,1);
% for i=1:ng_perm
%     BB{i} = (1+(i-1)*10:i*10);
% end
% for i= ng_perm+1:ng
%     BB{i} = i-ng_perm;
% end

% Define block set BB
BB = cell(ng,1);
BB{1} = 8:28;
for i= ng_perm+1:ng
    BB{i} = i-ng_perm;
end

% Define complexity of each block (group or single)
c = zeros(ng,1);
for i = 1:ng
%     c(i) = length(BB{i}) + log2(2*ng);
    c(i) = length(BB{i}) + log2(2*ng);
end

% Total complexity of the signal x0 (normaly we don't know that)
s = length(support) + (ns+1)*log2(2*ng);

[x_hat,sup,succ,grs] = Struct_OMP_test(A,y,BB,c,s,n,ng,ng_perm);
x_hat = x_hat./normAi;

disp(['||x-x0||_1 = ' num2str(norm(x0-x_hat,2))])

figure(1);
subplot(1,2,1);
stem(x0,'LineWidth',2);
title('Input x0');
subplot(1,2,2);
stem(x_hat,'LineWidth',2);
title('Recovered x');