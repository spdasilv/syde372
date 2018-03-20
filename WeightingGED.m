% Returns the new mean value 
function [m_new, weight] = WeightingGED( S, m )
    [V, D] = eig(S);
    
    if D(2,2) > D(1,1)
        temp = D(2,2);
        D(2,2) = D(1,1);
        D(1,1) = temp;
        
        V = -1*fliplr(V);
    end
    
    weight = inv(sqrt(D))*V';
    m_new = weight*m';
end

