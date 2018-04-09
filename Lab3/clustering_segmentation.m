function result = clustering_segmentation(seg_pts, prototypes)
    [r,c, ~] = size(seg_pts);
    
    result = zeros(r,c);

    for i=1:r
        for j=1:c
            pt = [seg_pts(i,j,1), seg_pts(i,j,2)];
            dists = pdist2(pt, prototypes);
            [~, closest_prot] = min(dists,[],2);
            result(i,j) = closest_prot;
        end
    end
end

