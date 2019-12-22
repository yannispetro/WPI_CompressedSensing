clc
clear all
close all

B = gaussian(0.1, 0.3, 200, 1000, 1);
[d, N] = size(B);
n = 4;
k = 4;
tol = 0.00001;
[D1, X, error] = K_SVD(B, n, k, tol, 20000);
save('D1','D1')

B = gaussian(0.2, 0.6, 200, 1000, 2);
[d, N] = size(B);
n = 4;
k = 4;
tol = 0.00001;
[D2, X, error] = K_SVD(B, n, k, tol, 20000);
save('D2','D2')
%%
set(0,'defaulttextinterpreter','latex')
set(0,'defaultaxesfontname','courier')
x1=linspace(-1,1,d);
x2=linspace(-2,2,d);
y1 = D1(:,1);
y2 = D2(:,1);

figure;
subplot(2,1,1)
plot(x1,y1,'o', 'Linewidth', 1.01)
ylim([-Inf,0.3])
xlabel('$x_1$')
ylabel('$d_{11}$')
title('First Dictionary Atom for [-1, 1]')
subplot(2,1,2)
plot(x2,y2,'*', 'Linewidth', 1.01)
ylim([-Inf,0.3])
xlabel('$x_2$')
ylabel('$$d_{21}$')
title('First Dictionary Atom for [-2, 2]')
print ('First_Dictionary_Atom.jpeg', '-djpeg', '-r1200')


y1 = D1(:,2);
y2 = D2(:,2);

figure;
subplot(2,1,1)
plot(x1,y1,'o', 'Linewidth', 1.01)
ylim([-Inf,0.3])
xlabel('$x_1$')
ylabel('$d_{12}$')
title('Second Dictionary Atom for [-1, 1]')
subplot(2,1,2)
plot(x2,y2,'*', 'Linewidth', 1.01)
ylim([-Inf,0.3])
xlabel('$x_2$')
ylabel('$$d_{22}$')
title('Second Dictionary Atom for [-2, 2]')
print ('Second_Dictionary_Atom.jpeg', '-djpeg', '-r1200')

y1 = D1(:,3);
y2 = D2(:,3);

figure;
subplot(2,1,1)
plot(x1,y1,'o', 'Linewidth', 1.01)
% ylim([-Inf,0.3])
xlabel('$x_1$')
ylabel('$d_{13}$')
title('Third Dictionary Atom for [-1, 1]')
subplot(2,1,2)
plot(x2,y2,'*', 'Linewidth', 1.01)
% ylim([-Inf,0.3])
xlabel('$x_2$')
ylabel('$$d_{23}$')
title('Third Dictionary Atom for [-2, 2]')
print ('Third_Dictionary_Atom.jpeg', '-djpeg', '-r1200')

y1 = D1(:,4);
y2 = D2(:,4);

figure;
subplot(2,1,1)
plot(x1,y1,'o', 'Linewidth', 1.01)
ylim([-Inf,0.3])
xlabel('$x_1$')
ylabel('$d_{14}$')
title('Fourth Dictionary Atom for [-1, 1]')
subplot(2,1,2)
plot(x2,y2,'*', 'Linewidth', 1.01)
ylim([-Inf,0.3])
xlabel('$x_2$')
ylabel('$$d_{24}$')
title('Fourth Dictionary Atom for [-2, 2]')
print ('Fourth_Dictionary_Atom.jpeg', '-djpeg', '-r1200')