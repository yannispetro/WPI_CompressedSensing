clc
clear all
close all

load('D1(n4k4)')
D1_100 = D1;
t_100 = linspace(-1, 1, 100);


d = 50;
n = 4;
k = 4;
tol = 0.0001;
N = 1000;
t_50 = linspace(-1, 1, d);


B = gaussian(0.1, 0.3, d, N, 1);
[D1_50, X, error] = K_SVD(B, n, k, tol, 10000);
save('D1(n4k4)','D1_50')

%%
y0_100=normpdf(t_100,0,0.1889);
y0_50=normpdf(t_50,0,0.1889);

m = 4:1:50;
mn = length(m);

for j = 1:mn
    err=0;
    for i=1:1000
        [phi, locations] = delete_rows(100, m(j));

        y = phi * y0_100.';
        A = phi * D1_100;

        x_hat = OMP(k, y.', A);
        y_hat = D1_100 * x_hat;
        err=err+1 / d * (norm(y_hat - y0_100.'))^2/1000;
    end
    avg_error_100(j) = err;
end

for j = 1:mn
    err=0;
    for i=1:1000
        [phi, locations] = delete_rows(50, m(j));

        y = phi * y0_50.';
        A = phi * D1_50;

        x_hat = OMP(k, y.', A);
        y_hat = D1_50 * x_hat;
        err=err+1 / d * (norm(y_hat - y0_50.'))^2/1000;
    end
    avg_error_50(j) = err;
end

%
tol = 10^-4;
set(0,'defaulttextinterpreter','latex')
set(0,'defaultaxesfontname','courier')
figure;
semilogy(m,avg_error_100,'-o', m,avg_error_50,'-*', m, tol * ones(1, mn), 'Linewidth', 1.01)
title(['Error for several values of d over 1000 runs'])
% xlim([m(1), m(mn)])
legend('Error for a typical signal for d = 100', 'Error for a typical signal for d = 50', 'Tolerance')
xlabel('m')
ylabel('Avg Error')
xlim([5,50])
print ('Error_dvar_mvar_N1000.jpeg', '-djpeg', '-r1200')