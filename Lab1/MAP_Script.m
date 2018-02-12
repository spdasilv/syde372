clear all; close all;
clc;
rng default;
%% Generating Clusters
% Class A
mu_A = [5 10];
cov_A = [8 0; 0 4];
A = mvnrnd(mu_A, cov_A, 200);

% Class B
mu_B = [10 15];
cov_B = [8 0; 0 4];
B = mvnrnd(mu_B, cov_B, 200);

mu_C = [5 10];
cov_C = [8 4; 4 40];
C = mvnrnd(mu_C, cov_C, 100);

% Class D
mu_D = [15 10];
cov_D = [8 0; 0 8];
D = mvnrnd(mu_D, cov_D, 200);

% Class E
mu_E = [10 5];
cov_E = [10 -5; -5 20];
E = mvnrnd(mu_E, cov_E, 150);

%% Discretize the feature space
P_A = 200/400;
P_B = 200/400;

P_C = 100/450;
P_D = 200/450;
P_E = 150/450;

N = 50;
M = 50;
dt = 0.1;

x_vector = -10:dt:N;
y_vector = -10:dt:M;
featureSpaceAB = zeros(length(x_vector), length(y_vector));
featureSpaceCDE = zeros(length(x_vector), length(y_vector));

for i=1:length(x_vector)
    for j = 1:length(y_vector)
        pos = [x_vector(i) y_vector(j)];
        
        MAP_AB = getMAPClass(pos, mu_A, cov_A, P_A, mu_B, cov_B, P_B);
        MAP_CD = getMAPClass(pos, mu_C, cov_C, P_C, mu_D, cov_D, P_D);
        MAP_CE = getMAPClass(pos, mu_C, cov_C, P_C, mu_E, cov_E, P_E);
        MAP_DE = getMAPClass(pos, mu_D, cov_D, P_D, mu_E, cov_E, P_E);
        
        featureSpaceAB(i,j) = MAP_AB;
        
        if MAP_CD == 1 && MAP_CE ==1
            featureSpaceCDE(i,j) = 1;
        elseif MAP_CD == 2 && MAP_DE ==1
            featureSpaceCDE(i,j) = 2;
        elseif MAP_CE == 2 && MAP_DE ==2
            featureSpaceCDE(i,j) = 3;
        else
            featureSpaceCDE(i,j) = 0;
        end
        
    end
end
%%
figure;
contourf(x_vector, y_vector, featureSpaceAB)
hold on
scatter(A(:,1), A(:,2), 'filled')
hold on;
scatter(B(:,1), B(:,2), 'filled')
hold on;
plot_ellipse(cov_A, mu_A);
hold on;
plot_ellipse(cov_B, mu_B);
hold on;
title('Plot for Class A and Class B')
legend('Boundary', 'Class A','Class B')
%%
figure;
contourf(x_vector, y_vector, featureSpaceCDE)
hold on
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
title('Plot for Class C, Class D, Class E')
legend('Boundary','Class C','Class D', 'Class E')
%% Error Analysis
errorMAP;