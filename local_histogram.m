clc;
clear;

% Read and convert the image to grayscale
A = double(rgb2gray(imread('images/picture.jpeg')));

[R, C] = size(A);

% Define block size
block_size = 128;

% Create an empty matrix to store the output image
D = zeros(R, C);

for i = 1:block_size:R
    for j = 1:block_size:C
        % Define the range for the current block
        row_end = min(i + block_size - 1, R);
        col_end = min(j + block_size - 1, C);
        
        % Extract the block from the image
        block = A(i:row_end, j:col_end);
        
        % Apply histogram equalization to the block
        equalized_block = hist_eq(block);
        
        % Store the equalized block in the output image
        D(i:row_end, j:col_end) = equalized_block;
    end
end

% Display the equalized image
imshow(D, []);

% Function for histogram equalization
function D = hist_eq(block)
    % Initialize matrices and vectors
    my_hist = zeros(1, 256);
    pdf = zeros(1, 256);
    cdf = zeros(1, 256);
    lut = zeros(1, 256);
    
    % Calculate frequencies (histogram)
    [R, C] = size(block);
    for i = 1:R
        for j = 1:C
            pixel_value = block(i, j);
            my_hist(pixel_value + 1) = my_hist(pixel_value + 1) + 1;    
        end
    end

    % Find the probability of each pixel (PDF)
    for i = 1:256
        pdf(i) = my_hist(i) / (R * C);
    end

    % Calculate cumulative distribution (CDF)
    cdf(1) = pdf(1);
    for i = 2:256
        cdf(i) = cdf(i - 1) + pdf(i);
    end

    % Apply the formula CDF * (L-1) to get the new intensity levels
    for i = 1:256
        lut(i) = round(cdf(i) * 255);
    end

    % Apply the look-up table to get the equalized image
    D = zeros(R, C);
    for i = 1:R
        for j = 1:C
            D(i, j) = lut(block(i, j) + 1);
        end
    end
end
