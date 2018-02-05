function nearest_position = NN( v , class )
    [N,M] = size(class); 
    nearest_position = 10000;
    for k=1:N
        d = getDistance(class(k,:), v);
        if d < nearest_position
            nearest_position = d;
        end
    end
end     