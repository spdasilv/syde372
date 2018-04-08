function [cimage] = MICD_p4(f, multf8)
    f_means = zeros(10, 2);
    f_covs = zeros(10, 2, 2);
    for i=1:10
        xijs = f(1:2,(i-1)*16+1:i*16);
        f_means(i, :) = mean(xijs,2);
        f_covs(i, :, :) = cov(xijs');
    end
    
    % Build Input
    input = zeros(2, 256*256);
    input_i = 1;
    for i=1:256
        for j=1:256
            input(1,input_i) = multf8(i,j,1);
            input(2,input_i) = multf8(i,j,2);
            input_i = input_i + 1;
        end
    end

    % MICD
    for i=1:10
        m = input - f_means(i, :)';
        results(i, :) = dot(m' * inv(squeeze(f_covs(i, :, :))), m', 2);
    end
    [~, decision] = min(results, [], 1);
    
    % Build cimage
    output = zeros(256, 256);
    output_i = 1;
    for i=1:256
        for j=1:256
            output(i,j) = decision(output_i);
            output_i = output_i + 1;
        end
    end
    
    cimage = output;
end
