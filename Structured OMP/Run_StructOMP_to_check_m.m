
ng_perm = 1;%floor(n/10); % number of groups
ng = n + ng_perm;      % size of B (all sets) cell matrix

% % % Create dictionary by deleting rows of the monomial basis
% num = 5;
% dof = 3;
% x_max = 1.0;
% D = Create_monomial_basis(num,dof,x_max);
% [phi, locations] = delete_rows(n, m);
% A = phi * D;
 
% % Create dictionary by deleting rows of an n x n random matrix
A = create_A(n,m);

% Compute the observations
y = A*x0;

% % % Preprocess data
[A,normAi] = normalize(A);

% Define block set BB
BB = cell(ng,1);
BB{1} = 8:28;
for i= ng_perm+1:ng
    BB{i} = i-ng_perm;
end

% Define complexity of each block (group or single)
c = zeros(ng,1);
for i = 1:ng
    c(i) = length(BB{i}) + log2(2*ng);
end

% Total complexity of the signal x0 (normaly we don't know that)
s = length(support) + (ns+1)*log2(2*ng);

[x_hat,sup,succ] = Struct_OMP(A,y,BB,c,s,n,ng,ng_perm);
x_hat = x_hat./normAi;

