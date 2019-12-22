clc
clear all
close all

n = 10;
m = 2;
[phi, locations] = delete_rows(n, m);

y = linspace(1, 10, n).';
y_m = phi * y;

D = randn(n);
D_m = phi * D;