clc
clear all
close all

load('signal_6')

n = length(x0);
m = 75;

% A = randn( m, n );
% % Create dictionary by deleting rows of the monomial basis
num = 5;
dof = 3;
x_max = 1.0;
D = Create_monomial_basis(num,dof,x_max);
[phi, locations] = delete_rows(n, m);
A = phi * D;
for i = 1:n
    A(:,i) = A(:,i) - mean(A(:,i));
    if norm(A(:,i),2) ~= 0
        A(:,i) = A(:,i)/norm(A(:,i),2);
    end
end
% Compute the observations
y = A*x0;

s_g = 10;
n_g = 8;

p = [s_g*ones(1,n_g) ones(1,n-s_g*n_g)];

lambda = 10e-3;
rho = 1;
alpha = 1;
[z, history] = group_lasso(A, y, lambda, p, rho, alpha);

x = z;
disp(['||x-x0||_1 = ' num2str(norm(x0-x,1))])

figure(1); 
subplot(1,2,1);
stem(x0,'LineWidth',2);
title('Input x0');
subplot(1,2,2);
stem(x,'LineWidth',2);
title('Recovered x');