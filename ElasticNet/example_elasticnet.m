clear; close all; clc;

% Fix stream of random numbers
s1 = RandStream.create('mrg32k3a','Seed', 42);
s0 = RandStream.setGlobalStream(s1);

% Create data set
n = 210; p = 210;
% correlation = 0.1;
% Sigma = correlation*ones(p) + (1 - correlation)*eye(p);
% mu = zeros(p,1);
% X = mvnrnd(mu, Sigma, n);
% % Model is lin.comb. of first three variables plus noise
% y = X(:,1) + X(:,2) + X(:,3) + 0.5*randn(n,1);

% Compute the observations
X = create_A(n,p);
load('signal_1')
y = X*x0;

% Preprocess data
X = normalize(X);
y = center(y);

% Run elastic net
delta = 1e-3;
[beta info] = elasticnet(X, y, delta, 0, true, true);

% Plot results
h1 = figure(1);
plot(info.s, beta, '.-');
best_ = 80;
line([info.s(best_) info.s(best_)], [-6 14], 'LineStyle', ':', 'Color', [1 0 0]);
xlabel('s'), ylabel('\beta', 'Rotation', 0)

% Restore random stream
RandStream.setGlobalStream(s0);

for i = 1:length(beta(1,:))
    err(i) = norm(normalize(beta(:,i))-normalize(x0));
end
