clc
clear all
close all

load('signal')

n = length(x0);
m = 75;

A = randn( m, n );

y     = A * x0;

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