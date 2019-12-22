clc
clear all
close all

NN = [1 4 6];
N = NN * 1000;
d = 60;
n = 4;
k = 4;
tol = 0.0001;

for l = 1:length(N)
    
    B = gaussian(0.1, 0.3, d, N(l), 1);
    [D1(:, :, l), X, err(l)] = K_SVD(B, n, k, tol, 1000);
    
end
%%
% addpath('C:\Users\psaro\Google Drive\Columbia\Sparse Representations - Spring 17 - Course Project\Sparse_code\Dictionary Learning\OLD_Codes\spgl1-1.9')
% opts = spgSetParms('verbosity',0);  
clear avg_error
m = 14:1:60;
mn = length(m);

x = linspace(-1, 1, d);
y0 = normpdf(x, 0, 0.249057282674).';
for l = 1:length(N)
    
    for j = 1:mn
        j
        err=0;
        for i=1:1000
            [phi, locations] = delete_rows(d, m(j));

            y = phi * y0;
            A = phi * D1(:, :, l);

            x_hat = OMP(k, y.', A);
%             x_hat = spg_bpdn(A,y,sqrt(m(j)*tol),opts);
            y_hat = D1(:, :, l) * x_hat;
            err=err+1 / d * (norm(y_hat - y0))^2/1000;
        end
        avg_error(l, j) = err;
    end
        
end
%
set(0,'defaulttextinterpreter','latex')
set(0,'defaultaxesfontname','courier')
figure;
hold on
title(['Avg Reconstruction Error for d = ' num2str(d) ' over 1000 runs'])
for i=1:length(N)
    semilogy(m,avg_error(i,:),'-o', 'Linewidth', 1.01)
    
end

plot(m, tol * ones(1, mn))
legend(['N = ' num2str(N(1))],['N = ' num2str(N(2))],['N = ' num2str(N(3))],'Tolerance')
xlabel('m')
ylabel('Avg Error')
% xlim([16, 60])
hold off
print ('Error_d60_mvar_Nvar.jpeg', '-djpeg', '-r1200')   
