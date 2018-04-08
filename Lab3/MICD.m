function [accuracy, cm] = MICD(f, ft)
    f_means = zeros(10, 2);
    f_vars = zeros(10, 2, 2);
    for i=1:10
        xijs = f(1:2,(i-1)*16+1:i*16);
        f_means(i, :) = mean(xijs,2);
        f_covs(i, :, :) = cov(xijs');
    end
    input = ft(1:2, :);
    target = ft(3, :);

    % MICD
    results = zeros(10, 160);
    for i=1:10
        m = input - f_means(i, :)';
        results(i, :) = dot(m' * inv(squeeze(f_covs(i, :, :))), m', 2);
    end
    [~, decision] = min(results, [], 1);
    
    % accuracy 
    accuracy = mean(decision == target);
    
    % confusion matrix
    cm = zeros(10,10);
    for idx = 1:length(target)
        i = target(idx);
        pred = decision(idx);
        cm(i, pred) = cm(i, pred) + 1;
    end
end
