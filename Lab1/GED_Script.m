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
%%
% Class C
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
[mu_trans_A, w_A] = GED( cov_A, mu_A, 2 );
[mu_trans_B, w_B] = GED( cov_B, mu_B, 2 );
[mu_trans_C, w_C] = GED( cov_C, mu_C, 3 );
[mu_trans_D, w_D] = GED( cov_D, mu_D, 3 );
[mu_trans_E, w_E] = GED( cov_E, mu_E, 3 );

A_trans = A*w_A;
B_trans = B*w_B;
C_trans = C*w_C;
D_trans = D*w_D;
E_trans = E*w_E;
%%
dt = 0.1;
x_vector = -12:dt:12;
y_vector = -12:dt:12;

N = length(x_vector);
M = length(y_vector); 

featureSpaceAB = zeros(N,M);
featureSpaceCDE = zeros(N,M);

for i = 1:length(x_vector)
    for j = 1:length(y_vector)
        pos = [x_vector(i) y_vector(j)];
        
        d_pos_A = getDistance(pos, mu_trans_A );
        d_pos_B = getDistance(pos, mu_trans_B );
        
        d_pos_C = getDistance(pos, mu_trans_C);
        d_pos_D = getDistance(pos, mu_trans_D);
        d_pos_E = getDistance(pos, mu_trans_E);
        
        min_dAB = min([d_pos_A  d_pos_B]);
        min_dCDE = min([d_pos_C  d_pos_D  d_pos_E]);
        
        if min_dAB == d_pos_A
            featureSpaceAB(i,j) = 1;
        elseif min_dAB == d_pos_B 
            featureSpaceAB(i,j) = 2;
        end
        
        if min_dCDE == d_pos_C
            featureSpaceCDE(i,j) = -1;
        elseif min_dCDE == d_pos_D 
            featureSpaceCDE(i,j) = 1;
        elseif min_dCDE == d_pos_E
            featureSpaceCDE(i,j) = 2;
        end
        
    end
end


%%
figure(1);
contourf(x_vector, y_vector, featureSpaceAB)
hold on;
scatter(A_trans(:,1), A_trans(:,2), 'filled')
hold on;
scatter(B_trans(:,1), B_trans(:,2), 'filled')
hold on;
plot_ellipse(eye(2), mu_trans_A);
hold on;
plot_ellipse(eye(2), mu_trans_B);
hold on;
axis equal
legend('GED Boundary', 'Class A_t','Class B_t')

%%
figure(2);
contourf(x_vector, y_vector, featureSpaceCDE)
hold on;
scatter(C_trans(:,1), C_trans(:,2), 'filled')
hold on;
scatter(D_trans(:,1), D_trans(:,2), 'filled')
hold on;
scatter(E_trans(:,1), E_trans(:,2), 'filled')
hold on;
plot_ellipse(eye(2), mu_trans_C);
hold on;
plot_ellipse(eye(2), mu_trans_D);
hold on;
plot_ellipse(eye(2), mu_trans_E);
hold on;
axis equal
legend('GED Boundary','Class C_t','Class D_t', 'Class E_t')

