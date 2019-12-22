clc
clear all
close all

load('D1(n4k4)')
d = size(D1, 1);
B = gaussian(0.1, 0.3, d, 1000, 1);

m = 4:1:100;
mn = length(m);

n = size(D1, 2);
k = 4;
tol = 10^-5;
y0 = B(:, 250);
%%
for j = 1:mn
    err=0;
    for i=1:1000
        [phi, locations] = delete_rows(d, m(j));

        y = phi * y0;
        A = phi * D1;

        x_hat = OMP(k, y.', A);
        y_hat = D1 * x_hat;
        err=err+1 / d * (norm(y_hat - y0))^2/1000;
    end
    avg_error(j) = err;
end

%%
set(0,'defaulttextinterpreter','latex')
set(0,'defaultaxesfontname','courier')
figure;
semilogy(m,avg_error,'o', m, tol * ones(1, mn), 'Linewidth', 1.01)
title(['Avg Reconstruction Error for d = ' num2str(d) ' over 1000 runs'])
xlim([m(1), m(mn)])
legend('Avg Error for a typical signal', 'Tolerance')
xlabel('m')
ylabel('Avg Error')
xlim([4,100])
print ('Error_d100_mvar_N1000.jpeg', '-djpeg', '-r1200')