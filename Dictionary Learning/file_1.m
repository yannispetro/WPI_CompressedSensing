clc
clear all
close all

nx=51;
x1=linspace(-1,1,nx);
x2=linspace(-2,2,nx);

y1 = normpdf(x1,0,0.1);
y2 = normpdf(x2,0,0.2);
% y1 = x1.^5+1;
% y2 = (2*x1).^5+1;
%
% tr2=(x1(2)-x1(1))*sum(y2);
tr2=y2(1)/y1(1);
set(0,'defaulttextinterpreter','latex')
set(0,'defaultaxesfontname','courier')
figure;
subplot(2,1,1)
plot(x1,y1,'o')
% ylim([0,5])
xlabel('$x_1$')
ylabel('$y_1$')
subplot(2,1,2)
plot(x2,y2,'*')
% ylim([0,5])
xlabel('$x_2$')
ylabel('$y_2$')
figure;
subplot(2,1,1)
plot(x1,y1,'o')
% ylim([0,5])
xlabel('$x_1$')
ylabel('$y_1$')
subplot(2,1,2)
plot(x2,y2/tr2,'*')
% ylim([0,5])
xlabel('$x_2$')
ylabel('$y_2/c_2$')

norm(y1-y2/tr2)
% figure;
% plot(linspace(1,nx,nx),y1,'o',linspace(1,nx,nx),y2/tr2,'*')



