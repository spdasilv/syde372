function NN = KNN( pos, k, class )
    [N, ~] = size(class);
    NNArray = zeros(N,1);
    for i = 1:N
        NNArray(i) = getDistance(pos, class(i,:));
    end
    sorted = sort(NNArray);
    NN = mean(sorted(1:k));
end

