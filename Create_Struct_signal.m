close all
clear all
clc

n = 200;

x0 = zeros(n,1);

piv = 10*randi([1 n/10-1],1,1)+1;
disp([piv piv+9]);
x0(piv:piv+9) = randn(10,1);
xg=x0;
a = randperm(12);
for i = 1:a(1)
    num=randi([1 n],1,1);
    while num<=piv+9&num>=piv
        num=randi([1 n],1,1)
    end
    x0(num) = randn(1,1);
end
support=find(x0);
ns = i;
save('signal','x0','support','ns','piv')

disp(a(1));
disp( find(x0));
figure;
hold on
stem(xg);
stem(x0-xg);
hold off