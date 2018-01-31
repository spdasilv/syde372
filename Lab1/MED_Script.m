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
N = 30;
M = 30;
featureSpaceAB = zeros(N,M);
featureSpaceCDE = zeros(N,M);
for i=1:N
    for j = 1:M
        pos = [i j];
        d_pos_A = getDistance(pos, mu_A);
        d_pos_B = getDistance(pos, mu_B);
        d_pos_C = getDistance(pos, mu_C);
        d_pos_D = getDistance(pos, mu_D);
        d_pos_E = getDistance(pos, mu_E);
        
        min_dAB = min([d_pos_A  d_pos_B]);
        min_dCDE = min([d_pos_C  d_pos_D  d_pos_E]);
        
        if min_dAB == d_pos_A
            featureSpaceAB(i,j) = 1;
        elseif min_dAB == d_pos_B 
            featureSpaceAB(i,j) = 2;
        end
        
        if min_dCDE == d_pos_C
            featureSpaceCDE(i,j) = 1;
        elseif min_dCDE == d_pos_D 
            featureSpaceCDE(i,j) = 2;
        elseif min_dCDE == d_pos_E
            featureSpaceCDE(i,j) = 3;
        end
        
    end
end

%%
figure;
scatter(A(:,1), A(:,2), 'filled')
hold on;
scatter(B(:,1), B(:,2), 'filled')
hold on;
imcontour(featureSpaceAB, 1)
hold on;
error_ellipse(cov_A, 'mu', mu_A, 'style', '-r')
hold on;
error_ellipse(cov_B, 'mu', mu_B, 'style', '-b')
hold on;
axis equal
title('Class A and B')
%%
figure;
scatter(C(:,1), C(:,2), 'filled')
hold on;
scatter(D(:,1), D(:,2), 'filled')
hold on;
scatter(E(:,1), E(:,2), 'filled')
hold on;
imcontour(featureSpaceCDE)
hold on;
error_ellipse(cov_C, 'mu', mu_C, 'style', '-r')
hold on;
error_ellipse(cov_D, 'mu', mu_D, 'style', '-b')
hold on;
error_ellipse(cov_E, 'mu', mu_E, 'style', '-g')
hold on;

%hold on; plot([mu_C(1) mu_D(1)], [mu_C(2) mu_D(2)]); 
%hold on; plot([mu_D(1) mu_E(1)], [mu_D(2) mu_E(2)]); 
%hold on; plot([mu_C(1) mu_E(1)], [mu_C(2) mu_E(2)]);

title('Plot for Class C, Class D, Class E')
legend('Class C','Class D', 'Class E')