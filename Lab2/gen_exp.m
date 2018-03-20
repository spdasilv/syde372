function [ result ] = gen_exp( rng, lambda )
    result = zeros(size(rng));
    
    for i=1:length(rng)
        result(i) = lambda*exp(-lambda*rng(i));
    end
end

