function NN = KNN( pos, k, class )
    [N, ~] = size(class);
    NNArray = zeros(N,1);
    for i = 1:N
        NNArray(i) = getDistance(pos, class(i,:));
    end
    [~, I] = sort(NNArray);
    NN_indices = I(1:k);
    nn = zeros(length(NN_indices), 2);
    for j = 1:length(NN_indices)
        nn(j,:) = class(NN_indices(j),:);
    end
    kNN = mean(nn,1);
    NN =  getDistance(pos, kNN);
end

