function [ class ] = discriminant_MED(mean_A, mean_B, X)
    dist_A = sqrt( (mean_A(1) - X(1))^2 + (mean_A(2) - X(2))^2 );
    dist_B = sqrt( (mean_B(1) - X(1))^2 + (mean_B(2) - X(2))^2 );
    if dist_A < dist_B
        class = 'A';
    else
        class = 'B';
    end
end

