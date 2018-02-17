clc;
% If classes are not present please run clusters.m
%% Discretize the feature space
N = 30;
M = 30;
dt = 0.1;

x_vector = -8:dt:N;
y_vector = -8:dt:M;

featureSpaceAB_GED = zeros(length(x_vector), length(y_vector));
featureSpaceCDE_GED = zeros(length(x_vector), length(y_vector));
% Closer to A - 1
% Closer to B - 0
for i=1:length(x_vector)
    for j = 1:length(y_vector)
        pos = [x_vector(i) y_vector(j)];
        d_pos_A = getGED( pos, mu_A, cov_A );
        d_pos_B = getGED( pos, mu_B, cov_B );
        
        min_dAB = min([d_pos_A  d_pos_B]);
        
        if min_dAB == d_pos_A
            featureSpaceAB_GED(i,j) = 1;
        elseif min_dAB == d_pos_B 
            featureSpaceAB_GED(i,j) = -1;
        end
        
        d_pos_C = getGED(pos, mu_C, cov_C);
        d_pos_D = getGED(pos, mu_D, cov_D);
        d_pos_E = getGED(pos, mu_E, cov_E);
        
        min_dCDE = min([d_pos_C  d_pos_D  d_pos_E]);
        
        if min_dCDE == d_pos_C
            featureSpaceCDE_GED(i,j) = 1;
        elseif min_dCDE == d_pos_D 
            featureSpaceCDE_GED(i,j) = -1;
        elseif min_dCDE == d_pos_E
            featureSpaceCDE_GED(i,j) = 5;
        end
    end
end
%%
figure(3)
contourf(x_vector, y_vector, featureSpaceAB_GED')
hold on
scatter(A(:,1), A(:,2), 'filled')
hold on
scatter(B(:,1), B(:,2), 'filled')
hold on
plot_ellipse(cov_A, mu_A);
hold on
plot_ellipse(cov_B, mu_B);
hold on
title('GED Boundary for Class A and B')
legend('GED Boundary', 'Class A','Class B')
%%
figure(4)
contourf(x_vector, y_vector, featureSpaceCDE_GED')
hold on;
scatter(C(:,1), C(:,2), 'filled')
hold on;
scatter(D(:,1), D(:,2), 'filled')
hold on;
scatter(E(:,1), E(:,2), 'filled')
hold on;
plot_ellipse(cov_C, mu_C);
hold on
plot_ellipse(cov_D, mu_D);
hold on
plot_ellipse(cov_E, mu_E);
hold on
title('GED Boundary for Class C, Class D, Class E')
legend('GED Boundary', 'Class C','Class D', 'Class E')

%% Error Calculation for Case 1

%%
class = B; % Switch this class to find the values for either side
listA = 0;
listB = 0;

for i=1:length(class)
    pos = class(i,:);
    
    d_pos_A = getGED(pos, mu_A, cov_A);
    d_pos_B = getGED(pos, mu_B, cov_B);
    
    min_d = min([d_pos_A  d_pos_B]);
        
    if min_d == d_pos_A
        listA = listA + 1;
    elseif min_d == d_pos_B 
        listB = listB + 1;
    end
    
end

listA
listB

%% Error Calc for Case 2

class = E; % Switch this

listCC = 0;
listCD = 0;
listCE = 0;

for i=1:length(class)
    pos = class(i,:);
    
    d_pos_CC = getGED(pos, mu_C, cov_C);
    d_pos_CD = getGED(pos, mu_D, cov_D);
    d_pos_CE = getGED(pos, mu_E, cov_E);
    
    min_d = min([d_pos_CC  d_pos_CD  d_pos_CE]);
        
    if min_d == d_pos_CC
        listCC = listCC + 1;
    elseif min_d == d_pos_CD 
        listCD = listCD + 1;
    elseif min_d == d_pos_CE
        listCE = listCE + 1;
    end
    
end
listCC
listCD
listCE