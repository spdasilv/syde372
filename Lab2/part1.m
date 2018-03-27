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
var_a = length(a)*var_a/(length(a) - 1);
var_b = length(b)*var_b/(length(b) - 1);

% Plot estimates
range_a = linspace(mu_a - 5, mu_a + 5, 1000); % generate 100 points between 0 and 10
org_a = normpdf(range_a, mu_org, var_org);
est_a = normpdf(range_a, mu_a, var_a);

range_b = linspace(0, mu_b + 5, 1000); % generate 100 points between 0 and 10
org_b = gen_exp(linspace(0, 5, 100), 1);
est_b = normpdf(range_b, mu_b, var_b);

figure;
plot(range_a, org_a)
hold on;
plot(range_a, est_a)
hold on;
plot(a, 0, 'gx')
legend('Actual', 'Estimation', 'Data points')
title('ML Gaussian Estimation of Dataset a')

figure;
plot(linspace(0, 5, 100), org_b)
hold on;
plot(range_b, est_b)
hold on;
plot(b, 0, 'gx')
legend('Actual', 'Estimation', 'Data points')
title('ML Gaussian Estimation of Dataset b')
%% Exponential Estimation
L_org = 1;
L_a = exponential( a );
L_b = exponential( b );

figure;
plot(range_a, org_a)
hold on;
plot(linspace(0,15,100), gen_exp(linspace(0,15,100), L_a))
hold on;
plot(a, 0, 'gx')
legend('Actual', 'Estimation', 'Data points')
title('ML Exponential Estimation of Dataset a')
%%
figure;
plot(linspace(0, 5, 100), org_b)
hold on;
plot(linspace(0,5,100), gen_exp(linspace(0,5,100), L_b))
hold on;
plot(b, 0, 'gx')
legend('Actual', 'Estimation', 'Data points')
title('ML Exponential Estimation of Dataset b')

%% Uniform Estimation
a_min = min(a); % For dataset a
a_max = max(a); % For dataset a

b_min = min(b); % For dataset b
b_max = max(b); % For dataset b

figure;
plot(range_a, org_a)
hold on;
rectangle('Position', [a_min 0 a_max-a_min 1/(a_max-a_min)])
hold on;
plot(a, 0, 'gx')
legend('Actual', 'Data points')
title('ML Uniform Estimation of Dataset a')

figure;
plot(linspace(0,5,100), gen_exp(linspace(0,5,100), L_b))
hold on;
rectangle('Position', [b_min 0 b_max-b_min 1/(b_max-b_min)])
hold on;
plot(b, 0, 'gx')
legend('Actual', 'Data points')
title('ML Uniform Estimation of Dataset b')
%% Parzen window Estimation
[gaus_0_1, rng_gaus_0_1] = parzen_gaussian(a, 0.1, 1);
[gaus_0_4, rng_gaus_0_4] = parzen_gaussian(a, 0.4, 1);
[exp_0_1, rng_exp_0_1] = parzen_gaussian(b, 0.1, 0);
[exp_0_4, rng_exp_0_4] = parzen_gaussian(b, 0.4, 0);

figure;
plot(range_a, org_a)
hold on;
plot(rng_gaus_0_1, gaus_0_1)
hold on;
plot(a, 0, 'gx')
legend('Actual', 'Estimation', 'Data points')
title('Parzen Window Estimation with Std Dev = 0.1 for dataset a')

figure;
plot(range_a, org_a)
hold on;
plot(rng_gaus_0_4, gaus_0_4)
hold on;
plot(a, 0, 'gx')
legend('Actual', 'Estimation', 'Data points')
title('Parzen Window Estimation with Std Dev = 0.4 for dataset a')
%%
figure;
plot(linspace(0,5,100), gen_exp(linspace(0,10,100), L_b))
hold on;
plot(rng_exp_0_1, exp_0_1)
hold on;
plot(b, 0, 'gx')
legend('Actual', 'Estimation', 'Data points')
title('Parzen Window Estimation with Std Dev = 0.1 for dataset b')

figure;
plot(linspace(0,10,100), gen_exp(linspace(0,10,100), L_b))
hold on;
plot(rng_exp_0_4, exp_0_4)
hold on;
plot(b, 0, 'gx')
legend('Actual', 'Estimation', 'Data points')
title('Parzen Window Estimation with Std Dev = 0.4 for dataset b')


