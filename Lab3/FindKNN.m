function [ k_nearest ] = FindKNN( K, data, prot )
    dist = zeros(length(data),1);
    
    for index = 1:length(data)
        dist(index) = sqrt(sum((data(index,:)-prot).^2));
    end
    [~,sorted_index] = sort(dist);
    k_sorted = sorted_index(1:K);
    k_nearest = data(k_sorted, :);
end

