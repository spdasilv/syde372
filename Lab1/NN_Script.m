clc;
% If classes are not present please run clusters.m
%% Nearest Neighbor
N = 36;
M = 36;

dt = 0.1;
x_vector = -7:dt:N;
y_vector = -7:dt:M;

featureSpaceAB_NN = zeros(length(x_vector), length(y_vector));
featureSpaceCDE_NN = zeros(length(x_vector), length(y_vector));

for i=1:length(x_vector)
    for j = 1:length(y_vector)
        pos = [x_vector(i) y_vector(j)];
        
        d_pos_A = NN(pos, A);
        d_pos_B = NN(pos, B);
        d_pos_C = NN(pos, C);
        d_pos_D = NN(pos, D);
        d_pos_E = NN(pos, E);

        min_dAB = min([d_pos_A  d_pos_B]);
        min_dCDE = min([d_pos_C  d_pos_D  d_pos_E]);

        if min_dAB == d_pos_A
            featureSpaceAB_NN(i,j) = 1;
        elseif min_dAB == d_pos_B
            featureSpaceAB_NN(i,j) = 2;
        end
        
        if min_dCDE == d_pos_C
            featureSpaceCDE_NN(i,j) = 1;
        elseif min_dCDE == d_pos_D 
            featureSpaceCDE_NN(i,j) = 2;
        elseif min_dCDE == d_pos_E
            featureSpaceCDE_NN(i,j) = 3;
        end
    end
end


%%
figure;
contourf(x_vector, y_vector, featureSpaceAB_NN')
hold on
scatter(A(:,1), A(:,2), 'filled')
hold on;
scatter(B(:,1), B(:,2), 'filled')
hold on;
plot_ellipse(cov_A, mu_A);
hold on;
plot_ellipse(cov_B, mu_B);
hold on;
title('NN Boundary for Class A and Class B')
legend('Boundary', 'Class A','Class B')
%%
figure;
contourf(x_vector, y_vector, featureSpaceCDE_NN')
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
title('NN Boundary for Class C, Class D, Class E')
legend('Boundary','Class C','Class D', 'Class E')

%% ERROR CALCULATION STUFF
rng(2);
X_A = mvnrnd(mu_A, cov_A, 200);
X_B = mvnrnd(mu_B, cov_B, 200);

%%
listAA = 0;
listBA = 0;
listAB = 0;
listBB = 0;

k = 1;
class = X_A;
ac = 'A';
nac = 'B';

for i=1:length(class)
    pos = class(i,:);
    
    d_pos_A = NN( pos, A );
    d_pos_B = NN( pos, B );
    
    d_pos_xA = NN( pos, X_A );
    d_pos_xB = NN( pos, X_B );
    
    actual = nac;
    if d_pos_A < d_pos_B
        actual = ac;
    end
    
    current = nac;
    if d_pos_xA < d_pos_xB
        current = ac;
    end
    
    if eq(actual, current)
        listAA = listAA + 1;
    else
        listAB = listAB + 1;
    end
end

listAA
listAB
P_A = listAB/(listAA + listAB)
% P_B = listBA/(listBB + listBA)

%% For Classes C, D and E
X_C = mvnrnd(mu_C, cov_C, 100);
X_D = mvnrnd(mu_D, cov_D, 200);
X_E = mvnrnd(mu_E, cov_E, 150);

listCC = 0;
listCD = 0;
listCE = 0;

class = X_E;

ac = 'E';
nac = 'C';
nac2 = 'D';

for i=1:length(class)
    pos = class(i,:);
    actual = ''; current = '';
    
    d_pos_xC = NN( pos, C );
    d_pos_xD = NN( pos, D );
    d_pos_xE = NN( pos, E );
    
    minCurrent = min([d_pos_xC  d_pos_xD  d_pos_xE]);
    
    if minCurrent == d_pos_xC
        current = ac;
        listCC = listCC + 1;
    elseif minCurrent == d_pos_xD
        current = nac;
        listCD = listCD + 1;
    elseif minCurrent == d_pos_xE
        current = nac2;
        listCE = listCE + 1;
    end
end
listCC
listCD
listCE
P_A = (listCD + listCE)/(listCC + listCD + listCE)
