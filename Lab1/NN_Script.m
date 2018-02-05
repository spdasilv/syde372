clear all;
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

figure(1)
plot(A(:,1), A(:,2), 'x')
hold on;
plot(B(:,1), B(:,2), 'o')
hold on;
title('Plot for Class A and Class B')
legend('Class A','Class B')

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

figure(2)
plot(C(:,1), C(:,2), 'x')
hold on;
plot(D(:,1), D(:,2), 'd')
hold on;
plot(E(:,1), E(:,2), 'o')
hold on;
title('Plot for Class C, Class D, Class E')
legend('Class C','Class D', 'Class E')

%% Nearest Neighbor
N = 20;
M = 20;
featureSpace = zeros(N,M);

for i=1:N
    for j = 1:M
        
        C_NN = NN([i j], C);
        D_NN = NN([i j], D);
        E_NN = NN([i j], E);

        min_d = min([C_NN, D_NN, E_NN]);

        if min_d == C_NN
            featureSpace(i,j) = 1;
        elseif min_d == D_NN 
            featureSpace(i,j) = 2;
        elseif min_d == E_NN
            featureSpace(i,j) = 3;
        end
    end
end

figure(3)
scatter(C(:,1), C(:,2), 'filled')
hold on;
scatter(D(:,1), D(:,2), 'filled')
hold on;
scatter(E(:,1), E(:,2), 'filled')
hold on;
imcontour(featureSpace)
hold on;
title('Plot for Class C, Class D, Class E')
legend('Class C','Class D', 'Class E')
        




