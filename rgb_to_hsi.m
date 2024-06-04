% Read and convert the image to grayscale
A = imread('images/strawberries.jpg');

[H,S,I] = rgb2hsi(A);

imshow(I,[]);

function [H,S,I] = rgb2hsi(RGB)
    % Convert the input image to double
    RGB = im2double(RGB);

    % Separate the RGB channels
    R = RGB(:,:,1);
    G = RGB(:,:,2);
    B = RGB(:,:,3);

    % Calculate the Intensity
    I = (R + G + B) / 3;

    % Calculate the Saturation
    min_val = min(min(R, G), B);
    S = 1 - (3 ./ (R + G + B + eps)) .* min_val;

    % Calculate the Hue
    num = 0.5 * ((R - G) + (R - B));
    den = sqrt((R - G).^2 + (R - B).*(G - B));
    theta = acos(num ./ (den + eps));

    H = theta;
    H(B > G) = 2 * pi - H(B > G);
    H = H / (2 * pi);

    % Combine the H, S, and I channels into an HSI image
    HSI = cat(3, H, S, I);
end
