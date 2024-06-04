% Load the image
img = imread('images/strawberries.jpg'); % Replace 'your_image.jpg' with your image file name

% Convert image to double precision
img = im2double(img);

% Define pure red and initialize parameters
W = 1; % Example threshold value, adjust as needed
pure_red = [0.8, 0.2, 0.5]; % Pure red in RGB

% Get image dimensions
[rows, cols, channels] = size(img);

% Initialize segmented image
segmented_img = img;

% Apply the segmentation rule for pure red
for i = 1:rows
    for j = 1:cols
        if abs(img(i, j, 1) - pure_red(1)) <= W / 2 && ...  % Check red channel
           abs(img(i, j, 2) - pure_red(2)) <= W / 2 && ...  % Check green channel
           abs(img(i, j, 3) - pure_red(3)) <= W / 2        % Check blue channel
            segmented_img(i, j, :) = pure_red; % Highlight pure red
        else
            segmented_img(i, j, :) = 0.5; % Set other pixels to gray
        end
    end
end

% Visualize the result
imshow(segmented_img);
title('Segmented Image - Pure Red');
