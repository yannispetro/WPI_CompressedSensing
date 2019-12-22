clc
clear all
close all

load('signals1')
B = Y(:, 1 : 5000); clear Y;
[d, N] = size(B);
n = 4;
k = 4;
tol = 0.0001;
[D1, X] = K_SVD(B, n, k, tol);
save('D1','D1')