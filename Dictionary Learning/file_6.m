clc
clear all
close all

load('D1(n4k4)')
B = gaussian(0.1, 0.3, 100, 1000, 1);
%%
m = [100 35];
mn = length(m);
d = size(D1, 1);
n = size(D1, 2);
k = 4;
N = 1000;
tol = 10^-4;

for i = 1:mn
    for j = 1:N
        y0 = B(:, j);
        err=0;
        for l = 1:1000
            
            [phi, locations] = delete_rows(d, m(i));

            y = phi * y0;
            A = phi * D1;

        %     for i = 1 : n
        %         nA(i) = norm(A(:, i), 2);
        %         A(:, i) = A(:, i) / nA(i);
        %     end

        %     x_hat = OMP(k, y.', A)./nA.';
            x_hat = OMP(k, y.', A);
            y_hat = D1 * x_hat;
            err=err+1 / d * (norm(y_hat - y0))^2/1000;
        %     x1=linspace(-1,1,d);
        %     figure;
        %     plot(x1, y_hat, '*', x1, y0, 'o')
        end
        avg_error(i, j) = err;
    end
end
%%
% mean_error = mean(avg_error,2);
% tol-mean_error>0
%%
set(0,'defaulttextinterpreter','latex')
set(0,'defaultaxesfontname','courier')

figure;
hold on
for i= 1:mn
    
    plot(linspace(1, N, N),avg_error(i,:))    
    xlabel('Signal i')
    ylabel('Avg Point Error')
end
legend(['m = ' num2str(m(1)) '(Representation Error)'],['m = ' num2str(m(2)) '(Reconstruction & Representation Error)'])
title(['Error for d = ' num2str(d) ' and several values of m'])
print ('Error_d100_mvar.jpeg', '-djpeg', '-r1200')



