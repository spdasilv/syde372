function NN = find_NN( v , class )
    [N,M] = size(class); 
    NN = 10000;
    for k=1:N
        d = getDistance(class(k,:), v);
        if d < NN
            NN = d;
        end
    end
end     
  
