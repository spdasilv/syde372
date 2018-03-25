%% Initiate Parameters
clear all; clc; close all;
rng(5);
S = load('lab2_3.mat');
class_A = S.a;
class_B = S.b;

discriminants(1) = discriminant;
J = 0;

%% Discretize the feature space
X = 600;
Y = 600;

dt = 1;
x_vector = 0:dt:X;
y_vector = 0:dt:Y;
%% Section 2 %
while(J < 20)
    true_A = 0;
    false_A = 0;
    true_B = 0;
    false_B = 0;
    
    length_A = size(class_A,1);
    length_B = size(class_B,1);
    
    incorrect_A = double.empty(0,2);
    incorrect_B = double.empty(0,2);
    
    rnd_A = randi([1 (length_A)],1,1);
    rnd_B = randi([1 (length_B)],1,1);

    mean_A = [class_A(rnd_A,1) class_A(rnd_A,2)];
    mean_B = [class_B(rnd_B,1) class_B(rnd_B,2)];
    
    for i=1:length_A
        if false_A > 0 && false_B > 0
            break
        end
        pos_A = [class_A(i,1) class_A(i,2)];
        class = discriminant_MED(mean_A, mean_B, pos_A);
        if class == 'A'
            true_A = true_A + 1;
        else
            false_B = false_B + 1;
            incorrect_A = [incorrect_A; pos_A];
        end
    end
    
    for i=1:length_B
        pos_B = [class_B(i,1) class_B(i,2)];
        class = discriminant_MED(mean_A, mean_B, pos_B);
        if class == 'B'
            true_B = true_B + 1;
        else
            false_A = false_A + 1;
            incorrect_B = [incorrect_B; pos_B];
        end
    end
    
    if false_A > 0 && false_B > 0
        continue;
    end
        
    % If loop is completed discriminant is good. Add to list.
    if J > 0
        disc = discriminant;
        disc.mean_A = mean_A;
        disc.mean_B = mean_B;
        disc.NbA = false_A;
        disc.NaB = false_B;
        discriminants = [discriminants; disc];
    else  
        discriminants(1,1).mean_A = mean_A;
        discriminants(1,1).mean_B = mean_B;
        discriminants(1,1).NbA = false_A;
        discriminants(1,1).NaB = false_B;
    end
    
    % Create and plot feature space
    featureSpace = zeros(length(x_vector), length(y_vector));
    for i=1:length(x_vector)
        for j = 1:length(y_vector)
            pos = [x_vector(i) y_vector(j)];
            class = discriminant_MED(mean_A, mean_B, pos);
            
            if class == 'A'
                featureSpace(i,j) = 1;
            else
                featureSpace(i,j) = 2;
            end
        end
    end
    
    figure;
    contourf(x_vector, y_vector, featureSpace', 'LineColor', 'k');
    hold on
    scatter(class_A(:,1), class_A(:,2), 'filled');
    hold on;
    scatter(class_B(:,1), class_B(:,2), 'filled');

    J = J + 1;
    
    if false_A == 0 && false_B == 0
        break;
    elseif false_A == 0
        class_A = incorrect_A;
    else
        class_B = incorrect_B;
    end
end

%% Run Discriminant Feature Space
featureSpaceDiscriminant = zeros(length(x_vector), length(y_vector));
errors = 0;
for i=1:length(x_vector)
    for j = 1:length(y_vector)
        pos = [x_vector(i) y_vector(j)];
        
        no_class = 1;
        for g=1:length(discriminants)
            class = discriminant_MED(discriminants(g).mean_A, discriminants(g).mean_B, pos);
            if class == 'A' && discriminants(g).NbA == 0
                featureSpaceDiscriminant(i,j) = 1;
                no_class = 0;
                break;
            elseif class == 'B' && discriminants(g).NaB == 0
                featureSpaceDiscriminant(i,j) = 2;
                no_class = 0;
                break;
            end
        end
        
        if no_class == 1
            errors = errors + 1;
        end
    end
end

figure;
contourf(x_vector, y_vector, featureSpaceDiscriminant', 'LineColor', 'k');
hold on
scatter(S.a(:,1), S.a(:,2), 'filled');
hold on;
scatter(S.b(:,1), S.b(:,2), 'filled');