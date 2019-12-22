clc
clear all
close all

%% Create data
mm=75; % This is NOT m; it's just for the calibration
load('signal.mat')
x0(19)=0;
n = length(x0);        % length of signal

A = randn( mm, n );
% for i = 1:n
%     A(:,i) = A(:,i) - mean(A(:,i));
%     A(:,i) = A(:,i)/norm(A(:,i),2);
% end
% Compute the observations
y = A*x0;

%% Fit
K=5; % K-fold
m_val=mm/5;
m=mm-m_val;
lamda=(301:15:2001)*10^-4;
CV=zeros(1,length(lamda));

% Algorithm Parameters
s_g = 10;
n_g = 8;
p = [s_g*ones(1,n_g) ones(1,n-s_g*n_g)];
rho = 1;
alpha = 1.5;
%
for j=1:length(lamda)
    j
    E=0;
    for i=1:K
%         i=1;
        y_val=y(1+(i-1)*m_val:i*m_val);
        A_val=A(1+(i-1)*m_val:i*m_val,:);
        y_lasso=y(setxor(1:mm,1+(i-1)*m_val:i*m_val));
        A_lasso=A(setxor(1:mm,1+(i-1)*m_val:i*m_val),:);
%         for i = 1:n            
%             A_lasso(:,i) = A_lasso(:,i)/norm(A_lasso(:,i),2);
%         end
        %DO LASSO with y_lasso and A_lasso and find x_hat//remember to normalize
        %the columns of A_lasso

        [x_hat, history] = group_lasso(A_lasso, y_lasso, lamda(j), p, rho, alpha);
        
        E=E+norm(y_val-A_val*x_hat);

    end
    CV(j)=1/K*E;
end

figure;
plot(lamda,CV)
%% Testing
% CV=[1 2 0 4 5 6];
[Min,Ind] = min(CV);
best_lamda=lamda(Ind)
x0_new=zeros(n,1);
x0_new(find(x0~=0))=x0(find(x0~=0))+rand(length(find(x0~=0)),1);
% x0_new=x0;

A_test=A(1:m,:);
y     = A_test * x0_new; % We have m points in total

[x_hat, history] = group_lasso(A_test, y, best_lamda, p, rho, alpha);

% Debiasing
active_set=find(abs(x_hat)>10^-2);
x_hat_hat=zeros(length(x_hat),1);
x_hat_hat(active_set)=inv(A_test(:,active_set).'*A_test(:,active_set))*A_test(:,active_set).'*y;

%
disp(['With Debiasing ||x-x0||_1 = ' num2str(norm(x0_new-x_hat_hat,1))])
disp(['Without Debiasing ||x-x0||_1 = ' num2str(norm(x0_new-x_hat,1))])
figure; 
subplot(1,2,1);

stem(x0_new,'LineWidth',2);
title('Input x0');
subplot(1,2,2);
stem(x_hat_hat,'LineWidth',2);
title('Recovered x');
