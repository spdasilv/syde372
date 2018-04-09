function updated_prot = RunKMeans( data, K )
    %% Define Seed
    rng(10,'twister') 
    %% Sample points from the dataset
    initial = datasample(data, K, 'Replace', false);
    %% Run K Means
    converged = false;
    updated_prot = zeros(size(initial));
    while ~converged
        % Find distances between all prototypes to each datasetpoint
        dists = pdist2(data, initial);
        % Find out the closest prot for each datapoint
        [~, closest_prot] = min(dists,[],2);
        % Cluster the same prot datapoints together
        for i = 1:K
            cluster_points = data(closest_prot==i,:);
            updated_prot(i,:) = mean(cluster_points);
        end
        
        if updated_prot == initial
            converged = true;
        else
            initial = updated_prot;
        end
    end
end

