clc
clear all

ex = 6;

load(['signals3/signal_' num2str(ex)])
n = length(x0);
m = 210;
k = 21+ex;

% % Create dictionary by deleting rows of the monomial basis
num = 25;
dof = 3;
x_max = 1.0;
D = Create_monomial_basis(num,dof,x_max);
% D = randn( n, n );
% D = dftmtx(n);
% rank(D)
[phi, locations] = delete_rows(n, m);
A = phi * D; 
y0 = D * x0;
y = phi * y0;
%% 
% % Create random dictionary


for i = 1:n
%     A(:,i) = A(:,i) - mean(A(:,i));
    if norm(A(:,i),2) ~= 0
        normAi(i) = norm(A(:,i),2);
        A(:,i) = A(:,i)/normAi(i);
    end
end

% x_hat = inv(A)*y;
x_hat = OMP(k,y.',A)./normAi.';

disp(['||x-x0||_1 = ' num2str(norm(x0-x_hat,2))])

figure(1);
subplot(1,2,1);
stem(x0,'LineWidth',2);
title('Input x0');
subplot(1,2,2);
stem(x_hat,'LineWidth',2);
title('Recovered x');