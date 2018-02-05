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

N = 30;
M = 30;
featureSpaceAB = zeros(N,M);
featureSpaceCDE = zeros(N,M);
for i=1:N
    for j = 1:M
        pos = [i j];
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
scatter(A(:,1), A(:,2), 'filled')
hold on;
scatter(B(:,1), B(:,2), 'filled')
hold on;
imcontour(featureSpaceAB)
hold on;
error_ellipse(cov_A, 'mu', mu_A, 'style', '-r')
hold on;
error_ellipse(cov_B, 'mu', mu_B, 'style', '-b')
hold on;
title('Plot for Class A and Class B')
legend('Class A','Class B')
%%
figure;
scatter(C(:,1), C(:,2), 'filled')
hold on;
scatter(D(:,1), D(:,2), 'filled')
hold on;
scatter(E(:,1), E(:,2), 'filled')
hold on;
imcontour(featureSpaceCDE, 4)
hold on;
error_ellipse(cov_C, 'mu', mu_C, 'style', '-r')
hold on;
error_ellipse(cov_D, 'mu', mu_D, 'style', '-b')
hold on;
error_ellipse(cov_E, 'mu', mu_E, 'style', '-g')
hold on;
title('Plot for Class C, Class D, Class E')
legend('Class C','Class D', 'Class E')
