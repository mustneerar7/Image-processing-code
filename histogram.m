clc;
clear;

% Read and convert the image to grayscale
A = double(rgb2gray(imread('images/picture.jpeg')));

[R, C] = size(A);

% Initialize matrices and vectors
D = zeros(R, C);
my_hist = zeros(1, 256);
pdf = zeros(1, 256);
cdf = zeros(1, 256);
lut = zeros(1, 256);

% Calculate frequencies (histogram)
for i = 1:R
    for j = 1:C
        pixel_value = A(i, j);
        my_hist(pixel_value + 1) = my_hist(pixel_value + 1) + 1;    
    end
end

% Find the probability of each pixel (PDF)
for i = 1:256
    pdf(i) = my_hist(i) / (R * C);
end

% Calculate cumulative distribution (CDF)
for i = 1:256
    if i == 1
        cdf(i) = pdf(i);
    else
        cdf(i) = cdf(i - 1) + pdf(i);
    end
end

% Apply the formula CDF * (L-1) to get the new intensity levels
for i = 1:256
    lut(i) = round(cdf(i) * 255);
end

% Apply the look-up table to get the equalized image
for i = 1:R
    for j = 1:C
        D(i, j) = lut(A(i, j) + 1);
    end
end

% Display results
subplot(1, 2, 1);
imshow(uint8(A));
title('Original Image');

subplot(1, 2, 2);
imshow(uint8(D));
title('Equalized Image');
