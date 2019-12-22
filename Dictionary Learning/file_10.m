clc
clear all
close all


d = 100;
n = 10;
k = 4;
tol = 0.0001;
N = 1000;
t = linspace(-1, 1, d);

B = gaussian(0.1, 0.3, d, N, 1);
[D1, X, error] = K_SVD(B, n, k, tol, 20000);
save('D1(n10k4)d100','D1')
%%
set(0,'defaulttextinterpreter','latex')
set(0,'defaultaxesfontname','courier')
figure;
subplot(2,2,1)
plot(t, -D1(:,1),'o', 'Linewidth', 1.01)
ylim([-0.2, 0.4])
xlabel('t')
ylabel('$d_1$')
title('1st Dictionary Atom')
subplot(2,2,2)
plot(t, -D1(:,2),'o', 'Linewidth', 1.01)
ylim([-0.2, 0.4])
xlabel('t')
ylabel('$d_2$')
title('2nd Dictionary Atom')
subplot(2,2,3)
plot(t, D1(:,3),'o', 'Linewidth', 1.01)
ylim([-0.2, 0.4])
xlabel('t')
ylabel('$d_3$')
title('3rd Dictionary Atom')
subplot(2,2,4)
plot(t, -D1(:,4),'o', 'Linewidth', 1.01)
ylim([-0.2, 0.4])
xlabel('t')
ylabel('$d_4$')
title('4th Dictionary Atom')
% subplot(3,2,5)
% plot(t, D1(:,5),'o', 'Linewidth', 1.01)
% xlabel('t')
% ylabel('$d_t$')
% title('5th Dictionary Atom')
% subplot(3,2,6)
% plot(t, D1(:,6),'o', 'Linewidth', 1.01)
% xlabel('t')
% ylabel('$d_6$')
% title('6th Dictionary Atom')
print ('Dictionary_d100_n10k4.jpeg', '-djpeg', '-r1200')