clc
clear all
close all

m = 35; % Define number of obdervations

load('signal.mat')

n = length(x0);        % length of signal
ng_perm = floor(n/10); % number of groups
ng = n + ng_perm;      % size of B (all sets) cell matrix

% Create random dictionary
A = randn( m, n );
for i = 1:n
    A(:,i) = A(:,i) - mean(A(:,i));
    A(:,i) = A(:,i)/norm(A(:,i),2);
end
% Compute the observations
y = A*x0;

% Define block set BB
BB = cell(ng,1);
for i=1:ng_perm
    BB{i} = (1+(i-1)*10:i*10);
end
for i= ng_perm+1:ng
    BB{i} = i-ng_perm;
end
BB_backup = BB;

% Define complexity of each block (group or single)
c = zeros(ng,1);
for i = 1:ng
    c(i) = length(BB{i}) + log2(2*ng);
end

% Total complexity of the signal x0 (normaly we don't know that)
s = length(support) + (ns+1)*log2(2*ng);

F = [];    % Will store the current block
x_hat = zeros(n,1); % Recovered signal
comp = 0; % Current total complexity
sup = []; % Support
BB2 = BB; % Temporary block set
corr = []; % Will store group id's that contain single blocks already added to sup
corr_temp = corr;
k = 0;
res=1;
while res>10^-6
    k = k + 1;
    max_gr = 0;
    
    if isempty(corr) % Normal case, corr empty
        % In this loop we find the best element (single or group) to add to the support
        for jj = 1:ng
            gr = gain_ratio( BB{jj},c(jj),A,x_hat,y );
            if k==1
                check(jj)=gr;
            end
            if gr > max_gr
                max_gr = gr;
                best_cand = jj;
            end
        end
    else % When corr in non-empty
        for i = 1:length(corr_temp)
            best_cand = corr_temp(i);
            corr = setdiff(corr, corr(i));
        end
    end
    
    F{k} = BB(best_cand); % Store current best block
    BB2{best_cand}=0;
    F_temp=cell2mat(F{k}); 
    comp = comp + c(best_cand); % Add complexity of best block to the total current complexity
    
    if length(F_temp)>1 % In case best block is a group
        ii = F_temp(1) + ng_perm; % Find location of single block equal to the first group elements
        
        BBB = cell2mat(BB2(ii:ii+9));
        norm_cond = norm(F_temp.' - BBB,2);
        
        if norm_cond == 0 % Means that none of the group (best_cand) elements has been considered individualy
            % Delete the single blocks that have been considered as a group
            BB(ii:ii+9) = cell(10,1); 
        else              % Means that at least one of the group (best_cand) elements has been considered individualy
            % In the next 10 lines we find the index (in the BB set)
            % corresponding to the group that contains 
            corr = F_temp(find(F_temp.'-BBB ~= 0)); 
            for i = 1:length(corr)
                for kk = 1:ng_perm
                    if any(BB{kk} == corr(i))
                        corr(i) = kk;
                    end
                end
            end
            corr = unique(corr);
            corr_temp = corr;
            corr
            
            F = [];
            x_hat = zeros(n,1);
            comp = 0;
            k = 0;
            sup = [];
            BB = BB_backup;
            BB2 = BB;
            continue
        end
        
    end
    BB{best_cand}=[];
%     BB{best_cand}=[];
%     comp = comp + c(best_cand);
    
    
    sup = cell2mat(cat(2,sup,F{k}));

    x_hat = zeros(n,1);
    [x_hat(sup), flag] = lsqr_gp(A(:,sup), y, sup.', 0.000001, 100000, [], [], []);
    res=norm(y-A*x_hat,2)
    
end
res=norm(y-A*x_hat,2)
comp

sup=sup.';
disp(['||x-x0||_1 = ' num2str(norm(x0-x_hat,1))])

figure(1);
subplot(1,2,1);
stem(x0,'LineWidth',2);
title('Input x0');
subplot(1,2,2);
stem(x_hat,'LineWidth',2);
title('Recovered x');