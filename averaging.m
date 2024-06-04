%Neighbourhood operation (Averaging) %

A = double(rgb2gray(imread('images/noisy.jpeg')));

[R, C] = size(A);

B = zeros(R, C);

avg = ones(3) * 1/9;
weighted_avg = [1,2,1;2,4,2;1,2,1] * 1/9;

sobel = [-1,-2,-1; 0,0,0; 1,2,1];
pitwise = [-1,-1,-1; 0,0,0; 1,1,1];

laplacian = [-1,-1,-1; -1, 8 , -1; -1, -1, -1];


for i = 2:R-1
    for j = 2:C-1  
        
        mat = [
            A(i-1, j-1), A(i-1, j), A(i-1, j+1); 
            A(i, j-1),   A(i, j),   A(i, j+1); 
            A(i+1, j-1), A(i+1, j), A(i+1, j+1)];
        
        % Get the median value
        B(i,j) = median(mat(:));
        
        % B(i,j) = sum(sum(mat .* avg))); %
        
    end
end

% Display the transformed image
imshow(uint8(B));
