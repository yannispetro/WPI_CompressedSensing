clc
clear all
close all

nx=51;
x1=linspace(-3,3,nx);
x2=linspace(-6,6,nx);
y1=exp(-x1.^2);
y2=exp(-x2.^2/(x2(1)^2/abs(log(y1(1)))));

set(0,'defaulttextinterpreter','latex')
set(0,'defaultaxesfontname','courier')
figure;
subplot(2,1,1)
plot(x1,y1,'o',x2,y2,'*', 'Linewidth', 1.01)
xlabel('x')
ylim([-Inf, 1.2])
legend('y1[x]', 'y2[x]','Location','NorthEast')
title('Time Domain')

subplot(2,1,2)
hold on
plot(fftshift(abs(dftmtx(nx)*y1.')),'o', 'Linewidth', 1.01)
plot(fftshift(abs(dftmtx(nx)*y2.')),'*', 'Linewidth', 1.01)
legend('Y1[n]', 'Y2[n]','Location','NorthEast')
xlim([1,51])
ylim([-Inf, 16])
xlabel('n')
title('Frequency Domain')
hold off

% print ('Time_Freq_Domain.jpeg', '-djpeg', '-r1200')