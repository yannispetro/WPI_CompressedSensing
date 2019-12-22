clc
clear all
close all

ng=5000;
nx=30;
Y=zeros(nx,100);
X=linspace(-1,1,nx);
dx=X(2)-X(1);
sigmas=linspace(0.1,0.3,ng);
for i=1:ng
    Y(:,i) = normpdf(X,0,sigmas(i));
end
figure;
plot(X,Y.')


n2=(nx-1)/2;
for i=1:n2
    
    Y(i:nx-(i-1), i+ng) = -(2*(X(i:nx-(i-1)) - min(X(i:nx-(i-1))))/(max(X(i:nx-(i-1))) - min(X(i:nx-(i-1)))) - 1).^2+1;
    Y(:, i+ng)=Y(:, i+ng)/trapz(Y(:, i+ng))/dx;
end
% figure;
% plot(X,Y(:,1050:1099).')
save('signals1','Y','nx')