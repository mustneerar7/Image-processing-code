% piecewise linear point pixel %
A = double(rgb2gray(imread('images/low.jpg')));

[R, C] = size(A);

B = zeros(R, C);

for i = 1:R
    for j = 1:C
        if (0 <= A(i,j)) && (A(i,j) <= 80)
            B(i, j) = A(i,j);
        elseif (80 < A(i,j)) && (A(i,j) <= 180)
            B(i,j) = 255 - A(i,j);
        else
            B(i,j) = 240;
        end
    end
end

% Display the stretched image
imshow(uint8(B));