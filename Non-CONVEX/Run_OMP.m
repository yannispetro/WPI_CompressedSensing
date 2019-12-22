clc
clear all
close all

m = 55;
n = 200;
% k = 20; 

A = randn( m, n );

% p = randperm(n);
% I = p(1:k);
% x0    = zeros(n,1);
% x0(I) = randn(k,1);

load('signal.mat')

% x0 = x;

y     = A * x0;
tol = 0.01;
tic
x = OMP(A,y,tol);
% 
% x = OMP_alternative(14,y.',A);
% x=x.';
toc
%
% % x = LS_OMP(A,y,tol);
% 
% % CHECK CENTERED/NORMALIZED A
% % b = LAR(A,y);
% % x = b(:,end);
% 
% b = LASSO(A,y);
% x = b(:,end-20);

disp(['||x-x0||_1 = ' num2str(norm(x0-x,1))])

figure(1); 
subplot(1,2,1);
stem(x0,'LineWidth',2);
title('Input x0');
subplot(1,2,2);
stem(x,'LineWidth',2);
title('Recovered x');

% figure(1); 
% subplot(1,3,1);
% stem(x0,'LineWidth',2);
% title('Input');
% subplot(1,3,2);
% stem(x,'LineWidth',2);
% title('Recovered');
% subplot(1,3,3);
% stem(x-x0,'LineWidth',2);
% title('Error x - x0');