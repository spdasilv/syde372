%% Initiate Parameters
clear all; clc; close all;
rng(5);
S = load('lab2_3.mat');
%% Discretize the feature space
X = 600;
Y = 600;

dt = 1;
x_vector = 0:dt:X;
y_vector = 0:dt:Y;
%% Simulations %
J = 1;
J_Max = 20;
max_errors = zeros(1,J_Max);
min_errors = zeros(1,J_Max);
avg_errors = zeros(1,J_Max);
std_errors = zeros(1,J_Max);
while(J < J_Max + 1)
    errors = zeros(1,20);
    for k=1:20
        
        class_A = S.a;
        class_B = S.b;
        discriminants(1) = discriminant;
        disc_count = 0;
        %% Build Discriminant
        while disc_count < J
            false_A = 0;
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
                if class == 'B'
                    false_B = false_B + 1;
                    incorrect_A = [incorrect_A; pos_A];
                end
            end

            for i=1:length_B
                pos_B = [class_B(i,1) class_B(i,2)];
                class = discriminant_MED(mean_A, mean_B, pos_B);
                if class == 'A'
                    false_A = false_A + 1;
                    incorrect_B = [incorrect_B; pos_B];
                end
            end

            if false_A > 0 && false_B > 0
                continue;
            end

            % If loop is completed discriminant is good. Add to list.
            if disc_count > 0
                disc = discriminant;
                disc.mean_A = mean_A;
                disc.mean_B = mean_B;
                disc.NbA = false_A;
                disc.NaB = false_B;
                discriminants = [discriminants; disc];
                disc_count = disc_count + 1;
            else  
                discriminants(1,1).mean_A = mean_A;
                discriminants(1,1).mean_B = mean_B;
                discriminants(1,1).NbA = false_A;
                discriminants(1,1).NaB = false_B;
                disc_count = disc_count + 1;
            end

            if false_A == 0 && false_B == 0
                break;
            elseif false_A == 0
                class_A = incorrect_A;
            else
                class_B = incorrect_B;
            end
        end
        
        %% Discriminant Analysis
        for i=1:length(S.a)
            for g=1:length(discriminants)
                pos_A = [S.a(i,1) S.a(i,2)];
                class = discriminant_MED(discriminants(g).mean_A, discriminants(g).mean_B, pos_A);
                if class == 'A' && (discriminants(g).NbA == 0 || g == length(discriminants))
                    break;
                elseif class == 'B' && (discriminants(g).NaB == 0 || g == length(discriminants))
                    errors(k) = errors(k) + 1;
                    break;
                end
            end
        end
        
        for i=1:length(S.b)
            for g=1:length(discriminants)
                pos_B = [S.b(i,1) S.b(i,2)];
                class = discriminant_MED(discriminants(g).mean_A, discriminants(g).mean_B, pos_B);
                if class == 'A' && (discriminants(g).NbA == 0 || g == length(discriminants))
                    errors(k) = errors(k) + 1;
                    break;
                elseif class == 'B' && (discriminants(g).NaB == 0 || g == length(discriminants))
                    break;
                end
            end
        end
        
        clear discriminants
    end
    
    max_errors(J) = max(errors);
    min_errors(J) = min(errors);
    avg_errors(J) = mean(errors);
    std_errors(J) = std(errors);
    
    J = J + 1;
end

figure;
bar(max_errors);
figure;
bar(min_errors);
figure;
bar(avg_errors);
figure;
bar(std_errors);