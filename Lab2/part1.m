%% Model estimation - 1D Case
clear all; clc; close all;
rng(5);
S = load('lab2_1.mat');
a = S.a;
b = S.b;
%% Gaussian Estimation
mu_org = 5; 
var_org = 1;
% For distribution a
[mu_a, var_a] = gaussian(a);
[mu_b, var_b] = gaussian(b);

% Fix the bias ((N-1)/N)
var_a = (length(a) - 1)*var_a/length(a);
var_b = (length(b) - 1)*var_b/length(b);

% Plot estimates
range_a = linspace(mu_a - 5, mu_a + 5, 1000); % generate 100 points between 0 and 10
org_a = normpdf(range_a, mu_org, var_org);
est_a = normpdf(range_a, mu_a, var_a);

range_b = linspace(0, mu_b + 10, 1000); % generate 100 points between 0 and 10
org_b = gen_exp(linspace(0, 10, 100), 1);
est_b = normpdf(range_b, mu_b, var_b);

figure;
plot(range_a, org_a)
hold on;
plot(range_a, est_a)
legend('Original Estimation', 'Approximation')

figure;
plot(linspace(0, 10, 100), org_b)
hold on;
plot(range_b, est_b)
legend('Original Estimation', 'Approximation')
%% Exponential Estimation
L_org = 1;
L_a = exponential( a );
L_b = exponential( b );

figure;
plot(linspace(0,10,100), gen_exp(linspace(0,10,100), L_a))
hold on;
plot(range_a, org_a)
legend('Original Estimation', 'Approximation')

figure;
plot(linspace(0,10,100), gen_exp(linspace(0,10,100), L_b))
hold on;
plot(linspace(0, 10, 100), org_b)
legend('Original Estimation', 'Approximation')




