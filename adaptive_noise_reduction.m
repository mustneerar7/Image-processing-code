clc;
clear;

A = double(rgb2gray(imread('images/picture.jpeg')));
[R,C] = size(A);

D = zeros(R,C);

global_mean = calculate_mean(A);
global_variance = calculate_variance(global_mean, A);

disp(global_mean);
disp(global_variance);

for i=1:128:R
    for j=1:128:C
        
        row_end = min(i + 128 - 1, R);
        col_end = min(j + 128 - 1, C);
        
        block = A(i:row_end, j:col_end);
        
        local_mean = calculate_mean(block);
        local_variance = calculate_variance(local_mean, block);
        
        if global_variance == 0
            D(i:row_end,j:col_end) = A(i,j);
            
        else if local_variance > global_variance
            %geometric mean%
            chunk = apply_geometric_filter(block,361);
            D(i:row_end, j:col_end) = chunk;
        else
            %arethemetic mean%
            chunk = apply_arethemetic_filter(block, 361);
            D(i:row_end, j:col_end) = chunk;
        end
        end
    end
end

imshow(D,[]);



% function to calculate mean %
function mean = calculate_mean(A)
    % Calculate the size of the image
    [R, C] = size(A);

    % Initialize histogram
    my_hist = zeros(1, 256);

    % Calculate frequencies (histogram)
    for i = 1:R
        for j = 1:C
            pixel_value = A(i, j);
            my_hist(pixel_value + 1) = my_hist(pixel_value + 1) + 1;    
        end
    end

    % Calculate global mean
    sum = 0;
    total_pixels = R * C;

    for i = 1:256
        sum = sum + (my_hist(i) * (i - 1));
    end

    mean = sum / total_pixels;
end

% function to calculate variance %
function variance = calculate_variance(mean, A)
    [R,C] = size(A);
    total_pixels = R*C;
    
    % Initialize histogram
    my_hist = zeros(1, 256);

    % Calculate frequencies (histogram)
    for i = 1:R
        for j = 1:C
            pixel_value = A(i, j);
            my_hist(pixel_value + 1) = my_hist(pixel_value + 1) + 1;    
        end
    end
    
    % calculate global variance %
    variance_sum = 0;
    for i = 1:256
        variance_sum = variance_sum + my_hist(i) * ((i - 1) - mean)^2;
    end

    variance = variance_sum / total_pixels;
end


% function to apply arethrmetic mean filter% 
function chunk = apply_arethemetic_filter(A, k_size)
    [R,C] = size(A);
    
    B = zeros(R,C);
    
    for i=2:R-1
        for j=2:C-1
            B(i,j) = sum((1/k_size) .* A(i,j));
        end
    end
    
    chunk = B;
end


% function to apply arethrmetic mean filter% 
function chunk = apply_geometric_filter(A, k_size)
    [R,C] = size(A);
    
    B = zeros(R,C);
    
    for i=2:R-1
        for j=2:C-1
            B(i,j) = prod(A(i,j))^1/k_size;
        end
    end
    
    chunk = B;
end
            
            
            
            
            
            




