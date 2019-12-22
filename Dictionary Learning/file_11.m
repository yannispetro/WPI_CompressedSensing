clc 
clear all
close all

d = 100;
B = gaussian(0.1, 0.3, d, 1000, 1);
y0 = B(:, 847);
m = 4:1:100;
mn = length(m);
k = 4;
tol = 10^-4;
%%
load('D1(n4k4)d100')
D_dense = D1;
load('D1(n10k4)d100')
D_sparse = D1;
for j = 1:mn
    err=0;
    for i=1:1000
        [phi, locations] = delete_rows(d, m(j));

        y = phi * y0;
        A = phi * D_dense;

        x_hat = OMP(k, y.', A);
        y_hat = D_dense * x_hat;
        err=err+1 / d * (norm(y_hat - y0))^2/1000;
    end
    avg_error_dense(j) = err;
end
for j = 1:mn
    err=0;
    for i=1:1000
        [phi, locations] = delete_rows(d, m(j));

        y = phi * y0;
        A = phi * D_sparse;

        x_hat = OMP(k, y.', A);
        y_hat = D_sparse * x_hat;
        err=err+1 / d * (norm(y_hat - y0))^2/1000;
    end
    avg_error_sparse(j) = err;
end
%%
set(0,'defaulttextinterpreter','latex')
set(0,'defaultaxesfontname','courier')
figure;
semilogy(m,avg_error_dense,'o',m,avg_error_sparse,'o', m, tol * ones(1, mn), 'Linewidth', 1.01)
title(['Avg Reconstruction Error for d = ' num2str(d) ' over 1000 runs'])
xlim([m(1), m(mn)])
legend('Avg Error for dense', 'Avg Error for sparse', 'Tolerance')
xlabel('m')
ylabel('Avg Error')
print ('Error_d100_mvar_N1000_n4k4_vs_n10k4.jpeg', '-djpeg', '-r1200')