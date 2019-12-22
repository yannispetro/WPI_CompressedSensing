clc
clear all
close all

n = 210;
N_run = 50;

D = randn( n, n );
% for i = 1:n
%     D(:,i) = D(:,i) - mean(D(:,i));
%     if norm(D(:,i),2) ~= 0
%         D(:,i) = D(:,i)/norm(D(:,i),2);
%     end
% end

% Group-LASSO Parameters
p = [7 21 ones(1,182)];
rho = 1;
alpha = 1.5;
K = 5; % K-fold CV
lamda = linspace(10^-4,5*10^-3,10);

errors = zeros(n,3);
for ex = 1:3
    load(['signals3/signal_' num2str(ex)])
    n = length(x0);        % length of signal
    for m = 4:4:168
        err = 0;
        mm=5*m/4; % This is NOT m; it's just for the calibration
        m_val = mm/5;

        [phi, locations]=delete_rows(n, mm);
        A = phi*D;

        % Compute the observations
        y = A*x0;
        
        % % % Preprocess data
        [A,normAi] = normalize(A);
        % y = center(y);
        
        select_lambda_group_lasso
        
        for r = 1:N_run
            [x_hat, history] = group_lasso(A, y, best_lambda, p, rho, alpha);
            err = err + norm(x0-x_hat,2);
        end
        errors(m,ex) = err/N_run;
        disp(num2str([ex m errors(m,ex)]))
    end
end

save('errors50_3_3','errors')