clc
clear all
close all

load('D1(n4k4)')

m = 50:50:2500;
mn = length(m);

D11 = kron(D1_50, D1_50);

d = size(D11, 1);
n = size(D11, 2);
k = 16;
tol = 10^-4;
% y0 = B(:, 450);

mu = [0 0];

x1=linspace(-1,1,50);
x2=linspace(-1,1,50);
[X1,X2] = ndgrid(x1,x2);
l=[X1(:) X2(:)];
Sigma_wocorr = [.10 0.0; 0.0 0.12];
y0_wocorr=mvnpdf([X1(:) X2(:)],mu,Sigma_wocorr);
Sigma_wcorr = [.10 0.05; 0.05 0.12];
y0_wcorr=mvnpdf([X1(:) X2(:)],mu,Sigma_wcorr);
F = reshape(y0_wcorr,50,50);
surf(F)
%%
for j = 1:mn
    err=0;
    j
    for i=1:100
        [phi, locations] = delete_rows(d, m(j));

        y = phi * y0_wocorr;
        A = phi * D11;

        x_hat = OMP(k, y.', A);
        y_hat = D11 * x_hat;
        err=err+1 / d * (norm(y_hat - y0_wocorr))^2/100;
    end
    avg_error_wocorr(j) = err;
end
for j = 1:mn
    err=0;
    j
    for i=1:100
        [phi, locations] = delete_rows(d, m(j));

        y = phi * y0_wcorr;
        A = phi * D11;

        x_hat = OMP(k, y.', A);
        y_hat = D11 * x_hat;
        err=err+1 / d * (norm(y_hat - y0_wcorr))^2/100;
    end
    avg_error_wcorr(j) = err;
end
%%
% surf(reshape(y_hat,30,30))
set(0,'defaulttextinterpreter','latex')
set(0,'defaultaxesfontname','courier')
figure;
semilogy(m,avg_error_wocorr,'o',m,avg_error_wcorr,'*', m, tol * ones(1, mn), 'Linewidth', 1.01)
title(['Avg Reconstruction Error for d = ' num2str(d) ' over 100 runs'])
xlim([m(1), m(mn)])
legend('Error without correlation', 'Error with correlation', 'Tolerance')
xlabel('m')
ylabel('Avg Error')
% xlim([100,2500])
print ('2D_Error_zero_w&wocorr.jpeg', '-djpeg', '-r1200')
