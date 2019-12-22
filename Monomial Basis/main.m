clc
clear all
close all


num = 9;
dof = 4;
x_max = 1.0;

x1_max = x_max;
x1 = linspace(-x1_max, x1_max, num);
dx1 = 2 * x1_max /(num - 1);
x2_max = x_max;
x2 = linspace(-x2_max, x2_max, num);
dx2 = 2 * x2_max /(num - 1);
x3_max = x_max;
x3 = linspace(-x3_max, x3_max, num);
dx3 = 2 * x3_max /(num - 1);
x4_max = x_max;
x4 = linspace(-x4_max, x4_max, num);
dx4 = 2 * x4_max /(num - 1);
x5_max = x_max;
x5 = linspace(-x5_max, x5_max, num);
dx5 = 2 * x4_max /(num - 1);
x6_max = x_max;
x6 = linspace(-x6_max, x6_max, num);
dx6 = 2 * x4_max /(num - 1);
x7_max = x_max;
x7 = linspace(-x7_max, x7_max, num);
dx7 = 2 * x4_max /(num - 1);
x8_max = x_max;
x8 = linspace(-x8_max, x8_max, num);
dx8 = 2 * x4_max /(num - 1);
[X1, X2, X3, X4, X5, X6, X7, X8] = ndgrid(x1, x2, x3, x4, x5, x6, x7, x8);
X1 = reshape(X1, num^(2*dof), 1); 
X2 = reshape(X2, num^(2*dof), 1);
X3 = reshape(X3, num^(2*dof), 1);
X4 = reshape(X4, num^(2*dof), 1);
X5 = reshape(X5, num^(2*dof), 1);
X6 = reshape(X6, num^(2*dof), 1);
X7 = reshape(X7, num^(2*dof), 1);
X8 = reshape(X8, num^(2*dof), 1);
grid = [X1 X2 X3 X4 X5 X6 X7 X8]; % Grid consisting of total number of points

% [X1, X2, X3, X4, X5, X6] = ndgrid(x1, x2, x3, x4, x5, x6);
% X1 = reshape(X1, num^(2*dof), 1); 
% X2 = reshape(X2, num^(2*dof), 1);
% X3 = reshape(X3, num^(2*dof), 1);
% X4 = reshape(X4, num^(2*dof), 1);
% X5 = reshape(X5, num^(2*dof), 1);
% X6 = reshape(X6, num^(2*dof), 1);
% grid = [X1 X2 X3 X4 X5 X6]; % Grid consisting of total number of points
%%
dim = 2 * dof;

[e, A] = S_line(dim);
n = max(size(e));
d = n;
dig = sort(randperm(num^(2 * dof), n)); % Random numbers to create the reduced grid
grid_red = grid(dig, :); % Grid that contains only the needed number of points 
D = MultiVander(e, A, grid_red);

% m = 50;

% [phi, locations] = delete_rows(n, m);

% for i = 1:n
%     D(:,i) = D(:,i) - mean(D(:,i));
%     if norm(D(:,i),2) ~= 0
%         D(:,i) = D(:,i)/norm(D(:,i),2);
%     end
% end
%%
% D = randn(n, n);
k = 45;
x0 = zeros(n, 1);
x0(sort(randperm(n, k))) = rand(k, 1);
y0 = D * x0; 
%%
m=80;
[phi, locations] = delete_rows(n, m);

A = phi * D;
y = phi * y0;

x_hat = l1_2(y,A);
% x_hat = OMP(k,y.',A)./normAi.';
% x_hat = OMP(k,y.',A);

% disp(['||x-x0||_1 = ' num2str(norm(x0-x_hat,2))])
%%
m = 170:5:250;
mn = length(m);
d=n;
tol = 10^-4;

runs = 1000;
for j = 1:mn
    j
    err=0;
    for i=1:runs
        [phi, locations] = delete_rows(d, m(j));

        y = phi * y0;
        A = phi * D;

%         x_hat = OMP(k, y.', A);
        x_hat = l1_2(y,A);
        y_hat = D * x_hat;
        err=err+1 / d * (norm(y_hat - y0))^2/runs;
    end
    avg_error(j) = err;
end


set(0,'defaulttextinterpreter','latex')
set(0,'defaultaxesfontname','courier')
figure;
semilogy(m,avg_error,'-o', m, tol * ones(1, mn), 'Linewidth', 1.01)
title(['Avg Reconstruction Error over ' num2str(runs) ' runs'])
xlim([m(1), m(mn)])
legend('Avg Error for a typical coefficient vector', 'Tolerance')
xlabel('m')
ylabel('Avg Error')
% xlim([4,100])
% print ('Error_d100_mvar_N1000.jpeg', '-djpeg', '-r1200')