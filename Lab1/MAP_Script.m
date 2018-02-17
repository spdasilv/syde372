clc;
% If classes are not present please run clusters.m
%% Discretize the feature space
P_A = 200/400;
P_B = 200/400;

P_C = 100/450;
P_D = 200/450;
P_E = 150/450;
%%
N = 30;
M = 30;
dt = 0.1;

x_vector = -8:dt:N;
y_vector = -8:dt:M;
featureSpaceAB_MAP = zeros(length(x_vector), length(y_vector));
featureSpaceCDE_MAP = zeros(length(x_vector), length(y_vector));

for i=1:length(x_vector)
    for j = 1:length(y_vector)
        pos = [x_vector(i) y_vector(j)];
        
        MAP_AB = getMAPClass(pos, mu_A, cov_A, P_A, mu_B, cov_B, P_B);
        MAP_CD = getMAPClass(pos, mu_C, cov_C, P_C, mu_D, cov_D, P_D);
        MAP_CE = getMAPClass(pos, mu_C, cov_C, P_C, mu_E, cov_E, P_E);
        MAP_DE = getMAPClass(pos, mu_D, cov_D, P_D, mu_E, cov_E, P_E);
        
        featureSpaceAB_MAP(i,j) = MAP_AB;
        
        if MAP_CD == 1 && MAP_CE ==1
            featureSpaceCDE_MAP(i,j) = 1;
        elseif MAP_CD == 2 && MAP_DE ==1
            featureSpaceCDE_MAP(i,j) = 2;
        elseif MAP_CE == 2 && MAP_DE ==2
            featureSpaceCDE_MAP(i,j) = 3;
        else
            featureSpaceCDE_MAP(i,j) = 0;
        end
        
    end
end
%%
figure;
contourf(x_vector, y_vector, featureSpaceAB_MAP')
hold on
scatter(A(:,1), A(:,2), 'filled')
hold on;
scatter(B(:,1), B(:,2), 'filled')
hold on;
plot_ellipse(cov_A, mu_A);
hold on;
plot_ellipse(cov_B, mu_B);
hold on;
title('MAP Boundary for Class A and Class B')
legend('Boundary', 'Class A','Class B')
%%
figure;
contourf(x_vector, y_vector, featureSpaceCDE_MAP')
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
title('MAP Boundary for Class C, Class D, Class E')
legend('Boundary','Class C','Class D', 'Class E')
%% Error Analysis
% errorMAP;

%%
listA = 0;
listB = 0;

actual = 2;

for i=1:length(A)
    pos = B(i,:);
    current = getMAPClass(pos, mu_A, cov_A, P_A, mu_B, cov_B, P_B);
    
    if current == actual
        listA = listA + 1;
    else
        listB = listB + 1;21    
    end
end
listA
listB

%%

listCC = 0;
listCD = 0;
listCE = 0;

class = E;

for i=1:length(class)
    pos = class(i,:);
    
    MAP_CD = getMAPClass(pos, mu_C, cov_C, P_C, mu_D, cov_D, P_D);
    MAP_CE = getMAPClass(pos, mu_C, cov_C, P_C, mu_E, cov_E, P_E);
    MAP_DE = getMAPClass(pos, mu_D, cov_D, P_D, mu_E, cov_E, P_E);

    if MAP_CD == 1 && MAP_CE ==1
        listCC = listCC + 1; 
    elseif MAP_CD == 2 && MAP_DE ==1
        listCD = listCD + 1; 
    elseif MAP_CE == 2 && MAP_DE ==2
        listCE = listCE + 1; 
    end
    
end
listCC
listCD
listCE
