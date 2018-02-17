function X = getScatter( cov, mean, N, seed )
    if seed == -1
        rng default;
    else
        rng(seed);
    end
    X = randn(N,2);
    [V,D] = eig(cov);
    X = (sqrt(D)*V*X' + mean')';
end