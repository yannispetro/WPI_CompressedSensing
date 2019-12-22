clc
clear all
close all

m = 40;

load('signal.mat')

n = length(x0); % length of signal
ng_perm = floor(n/10); % number of groups
ng = n + ng_perm; % size of B (all sets) cell matrix

% Define set of groups
BB = cell(ng,1);
% ng = length(BB);
for i=1:ng_perm
    BB{i} = (1+(i-1)*10:i*10);
end
for i= ng_perm+1:ng
    BB{i} = i-ng_perm;
end
BB_backup = BB;

% Define complexity of each group
c = zeros(ng,1);
for i = 1:ng
    c(i) = length(BB{i}) + log2(2*ng);
end

A = randn( m, n );
for i = 1:n
    A(:,i) = A(:,i) - mean(A(:,i));
    A(:,i) = A(:,i)/norm(A(:,i),2);
end

y = A*x0;
s = length(support) + (ns+1)*log2(2*ng);

F = [];
x_hat = zeros(n,1);
comp = 0;

k = 0;
x = zeros(n,1);
sup = [];
BB2 = BB;
corr=0;
corr_temp = corr;
while (comp < s) && abs(comp-s) >= 10^-8
    k = k + 1;
    max_gr = 0;
    ind_max_gr = 1;

    % In this loop we find the best element (single or group) to add to the support
    for jj = 1:ng
        gr = gain_ratio( BB{jj},c(jj),A,x_hat,y );
        if k==1
            check(jj)=gr;
        end
        if gr > max_gr
            max_gr = gr;
            ind_max_gr = jj;
        end

    end
    
    % We store the best element
    if corr==0
        F{k} = BB(ind_max_gr);
        % Here we eliminate this element from further consideration
        BB{ind_max_gr}=[];
        BB2{ind_max_gr}=0;
        F_temp=cell2mat(F{k});
        comp = comp + c(ind_max_gr);
    else
        for i = 1:length(corr_temp)
            for kk = 1:ng_perm
                if any(corr_temp(i)==BB{kk})
                    F{k} = BB(kk);
                    BB{kk}=[];
                    BB2{kk}=0;
                    F_temp=cell2mat(F{k});
                    comp = comp + c(kk);
                    corr_temp(i) = 0;
                    corr = setdiff(corr, corr(i));
                end
            end
        end
    end
    
    if length(F_temp)>1
%             B_con = cell2mat(BB(ng_perm+1:end));
        ii = F_temp(1) + ng_perm;
        
        BBB = cell2mat(BB2(ii:ii+9));
        norm_cond = norm(F_temp.' - BBB,2);
        if norm_cond == 0
            BB(ii:ii+9) = cell(10,1);
        else
            corr = F_temp(find(F_temp.'-BBB ~= 0));
            corr_temp = corr;
            corr
            F = [];
            x_hat = zeros(n,1);
            comp = 0;
            k = 0;
            x = zeros(n,1);
            sup = [];
            BB = BB_backup;
            BB2 = BB;
            continue
        end
    end
%     BB{ind_max_gr}=[];
%     comp = comp + c(ind_max_gr);
    
    
    
    
    
    
    sup = cell2mat(cat(2,sup,F{k}));

    x_hat = zeros(n,1);
    [x_hat(sup), flag] = lsqr_gp(A(:,sup), y, sup.', 0.000001, 100000, [], [], []);
end

sup=sup.';
disp(['||x-x0||_1 = ' num2str(norm(x0-x_hat,1))])

% figure(1); 
% subplot(1,2,1);
% stem(x0,'LineWidth',2);
% title('Input x0');
% subplot(1,2,2);
% stem(x_hat,'LineWidth',2);
% title('Recovered x');