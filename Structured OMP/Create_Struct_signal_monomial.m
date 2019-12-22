close all
clear all
clc

n = 210;

x0 = zeros(n,1);

gfd = randperm(n - 10);
piv = gfd(1);


x0(8:28) = randn(21,1);

xg=x0;
%===========
a = 4;
%===========
b = randperm(210 - 28);
for i = 1:a
    x0(b(i)+28) = randn(1,1);
end
support=find(x0);
ns = i;
save(['signal_' num2str(a)],'x0','support','ns','piv')

disp(a(1));
disp( find(x0));
figure;
hold on
stem(xg);
stem(x0-xg);
hold off