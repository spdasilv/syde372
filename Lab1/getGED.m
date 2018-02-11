function d = getGED( x, z, S )
    d = sqrt((x-z)*inv(S)*(x-z)');
end

