clear all; close all;
clc;
%% Generating Clusters
seed = 4; % Set -1 for default
% Class A
mu_A = [5 10];
cov_A = [8 0; 0 4];
A = getScatter( cov_A, mu_A, 200, seed );

% Class B
mu_B = [10 15];
cov_B = [8 0; 0 4];
B = getScatter( cov_B, mu_B, 200, seed );

figure;
scatter(A(:,1), A(:,2), 'filled')
hold on;
scatter(B(:,1), B(:,2), 'filled')
hold on;
plot_ellipse(cov_A, mu_A);
hold on;
plot_ellipse(cov_B, mu_B);
hold on;
plot(mu_A(1), mu_A(2), '*b')
hold on;
plot(mu_B(1), mu_B(2), '*b')
hold on;
title('Plot for Class A and Class B')
legend('Class A','Class B')
axis equal
%%
% Class C
mu_C = [5 10];
cov_C = [8 4; 4 40];
C = getScatter( cov_C, mu_C, 100, seed );

% Class D
mu_D = [15 10];
cov_D = [8 0; 0 8];
D = getScatter( cov_D, mu_D, 200, seed );

% Class E
mu_E = [10 5];
cov_E = [10 -5; -5 20];
E = getScatter( cov_E, mu_E, 150, seed );

figure;
scatter(C(:,1), C(:,2), 'filled')
hold on;
scatter(D(:,1), D(:,2), 'filled')
hold on;
scatter(E(:,1), E(:,2), 'filled')
hold on;
plot_ellipse(cov_C, mu_C);
hold on;
plot_ellipse(cov_D, mu_D);
hold on;
plot_ellipse(cov_E, mu_E);
hold on;
plot(mu_C(1), mu_C(2), '*b')
hold on;
plot(mu_D(1), mu_D(2), '*b')
hold on;
plot(mu_E(1), mu_E(2), '*b')
hold on;
title('Plot for Class C, Class D, Class E')
legend('Class C','Class D', 'Class E')
axis equal


