% Contrast stretching using formula %

A = double(rgb2gray(imread('images/low.jpg')));

[R, C] = size(A);

B = zeros(R, C);

r_min = min(min(A));
r_max = max(max(A));

L = 256;

for i = 1:R
    for j = 1:C
        % Perform contrast stretching
        B(i, j) = (A(i, j) - r_min) * (L / (r_max - r_min));
    end
end

% Display the stretched image
imshow(uint8(B));
