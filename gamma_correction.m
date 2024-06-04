% Gamma correction (Power law) %
A = double(rgb2gray(imread('images/low.jpg')));

[R, C] = size(A);

B = zeros(R, C);

gamma = 1.5;

for i = 1:R
    for j = 1:C
        B(i, j) = A(i, j) ^ 1/gamma;
    end
end

% Display the transformed image
imshow(uint8(B));
