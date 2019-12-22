clc
clear all
close all

load('signals1')
B = Y(:, 1 : 1000); clear Y;
[d, N] = size(B);
n = 4;
k = 4;
tol = 0.0001;
[D1, X] = K_SVD(B, n, k, tol);

%%
load('D1(n4k4)d100')
x=linspace(-1, 1, 100);
D11 = kron(D1, D1);

set(0,'defaulttextinterpreter','latex')
set(0,'defaultaxesfontname','courier')
figure;
h = surf(x, x, reshape(D11(:, 1), d, d))
view([360 90]);
xlabel('$t_1$')
ylabel('$t_2$')
colorbar
set(h, 'edgecolor','none');
set(gca, 'fontsize', 11)
print ('D11(1).jpeg', '-djpeg', '-r1200')