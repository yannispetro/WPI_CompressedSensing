clc
clear all
close all

load('signal')

n = length(x0);
m = 60;

A = randn( m, n );

y     = A * x0;
tol = 0.001;

% CHECK CENTERED/NORMALIZED A

% b = LAR(A,y);
% b = LASSO(A,y);
% x = b(:,end);

lambda = 1.;
tol = 1e-10;
x = APG(A,y,lambda,tol);

disp(['||x-x0||_1 = ' num2str(norm(x0-x,1))])
disp(['||x-x0||_2 = ' num2str(norm(x0-x,2))])

figure(1); 
subplot(1,2,1);
stem(x0,'LineWidth',2);
title('Input x0');
subplot(1,2,2);
stem(x,'LineWidth',2);
title('Recovered x');