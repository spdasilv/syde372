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
N = 36;
M = 36;
dt = 0.1;

x_vector = -7:dt:N;
y_vector = -7:dt:M;
featureSpaceAB = zeros(length(x_vector), length(y_vector));
featureSpaceCDE = zeros(length(x_vector), length(y_vector));

k = 5;

for i=1:length(x_vector)
    for j = 1:length(y_vector)
        pos = [x_vector(i) y_vector(j)];
        
        d_pos_A = KNN( pos, k, A );
        d_pos_B = KNN( pos, k, B );
        d_pos_C = KNN( pos, k, C );
        d_pos_D = KNN( pos, k, D );
        d_pos_E = KNN( pos, k, E );
        
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
legend('', 'Class A','Class B')
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
legend('', 'Class C','Class D', 'Class E')
