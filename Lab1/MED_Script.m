clc;
% If classes are not present please run clusters.m
%% Discretize the feature space
N = 30;
M = 30;

dt = 0.1;
x_vector = -8:dt:N;
y_vector = -8:dt:M;

featureSpaceAB_MED = zeros(length(x_vector), length(y_vector));
featureSpaceCDE_MED = zeros(length(x_vector), length(y_vector));

for i=1:length(x_vector)
    for j = 1:length(y_vector)
        pos = [x_vector(i) y_vector(j)];
        
        d_pos_A = getDistance(pos, mu_A);
        d_pos_B = getDistance(pos, mu_B);
        d_pos_C = getDistance(pos, mu_C);
        d_pos_D = getDistance(pos, mu_D);
        d_pos_E = getDistance(pos, mu_E);
        
        min_dAB = min([d_pos_A  d_pos_B]);
        min_dCDE = min([d_pos_C  d_pos_D  d_pos_E]);
        
        if min_dAB == d_pos_A
            featureSpaceAB_MED(i,j) = 1;
        elseif min_dAB == d_pos_B 
            featureSpaceAB_MED(i,j) = 2;
        end
        
        if min_dCDE == d_pos_C
            featureSpaceCDE_MED(i,j) = 1;
        elseif min_dCDE == d_pos_D 
            featureSpaceCDE_MED(i,j) = 2;
        elseif min_dCDE == d_pos_E
            featureSpaceCDE_MED(i,j) = 3;
        end
        
    end
end

%%
figure;
contourf(x_vector, y_vector, featureSpaceAB_MED', 'LineColor', 'k')
hold on
scatter(A(:,1), A(:,2), 'filled')
hold on;
scatter(B(:,1), B(:,2), 'filled')
hold on;
plot_ellipse(cov_A, mu_A);
hold on;
plot_ellipse(cov_B, mu_B);
hold on;
title('MED Decision Boundary for Class A and Class B')
legend('Boundary', 'Class A','Class B')
%%
figure;
contourf(x_vector, y_vector, featureSpaceCDE_MED')
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
title('MED Decision Boundary Class C, Class D, Class E')
legend('Boundary','Class C','Class D', 'Class E')

%% Error Calculations for Case I
class = B; % Switch this to class _ to find the classifications of that class
current = 0; opposite = 0;

for i=1:length(class)
    pos = [class(i,1) class(i,2)];
    d_pos_A = getDistance(pos, mu_A);
    d_pos_B = getDistance(pos, mu_B);

    min_dAB = min([d_pos_A  d_pos_B]);
        
    if min_dAB == d_pos_A
        current = current + 1;
    elseif min_dAB == d_pos_B 
        opposite = opposite + 1;
    end     
end

%% Error Calculations for Case I
class = E; % Switch this to class _ to find the classifications of that class
current = 0; opposite = 0; opposite2 = 0;

for i=1:length(class)
    pos = [class(i,1) class(i,2)];
    
    d_pos_C = getDistance(pos, mu_C);
    d_pos_D = getDistance(pos, mu_D);
    d_pos_E = getDistance(pos, mu_E);
    
    min_dCDE = min([d_pos_C  d_pos_D  d_pos_E]);
        
    if min_dCDE == d_pos_C
        current = current + 1;
    elseif min_dCDE == d_pos_D 
        opposite = opposite + 1;
    elseif min_dCDE == d_pos_E
        opposite2 = opposite2 + 1;
    end
end

current
opposite
opposite2