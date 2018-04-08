function [classImage] = convertToClass(image, f8)
    classes = f8(3, :);
    
    output = zeros(256, 256);
    for i=1:256
        for j=1:256
            if image(i,j) > 160
                image(i,j) = 160;
            end
            class = classes(image(i,j));
            output(i,j) = class;
        end
    end
    
    classImage = output;
end
