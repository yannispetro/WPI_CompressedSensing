m = 50;
n = 100;
k = 15; 

A = randn( m, n );

p = randperm(n);
I = p(1:k);
x0    = zeros(n,1);
x0(I) = randn(k,1);

y     = A * x0;
tol = 0.01;

% x = OMP(A,y,tol);
x1 = OMP(A,y,tol);
x2 = LS_OMP(A,y,tol);

disp(['||x1-x0||_1 = ' num2str(norm(x0-x1,1))])
disp(['||x2-x0||_1 = ' num2str(norm(x0-x2,1))])

figure(1); 
subplot(1,3,1);
stem(x0,'LineWidth',1);
title('Input x0');
subplot(1,3,2);
stem(x1,'LineWidth',1);
title('OMP recovery - x1');
subplot(1,3,3);
stem(x2,'LineWidth',1);
title('LS-OMP recovery - x2');

% figure(1); 
% subplot(1,3,1);
% stem(x0,'LineWidth',2);
% title('Input');
% subplot(1,3,2);
% stem(x,'LineWidth',2);
% title('Recovered');
% subplot(1,3,3);
% stem(x-x0,'LineWidth',2);
% title('Error x - x0');