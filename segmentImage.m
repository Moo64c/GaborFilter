function [maskedImage, BW] = segmentImage(original_path, file_path, foregroundInd, backgroundInd)
%segmentImage Segment image using auto-generated code from imageSegmenter App
%  [BW,MASKEDIMAGE] = segmentImage(RGB) segments image RGB using
%  auto-generated code from the imageSegmenter App. The final segmentation
%  is returned in BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 11-Mar-2018
%----------------------------------------------------
original = imread(original_path);
RGB = imread(file_path);
% Convert RGB image into L*a*b* color space.
X = rgb2lab(RGB);

% Graph Cut
L = superpixels(X,499,'IsInputLab',true);

% Convert L*a*b* range to [0 1]
scaledX = X;
scaledX(:,:,1) = X(:,:,1) / 100;
scaledX(:,:,2:3) = (X(:,:,2:3) + 100) / 200;
BW = lazysnapping(scaledX,L,foregroundInd,backgroundInd);

% Create masked image.
maskedImage = original;
maskedImage(repmat(~BW,[1 1 3])) = 0;
imwrite(maskedImage, 'maskedImage.png')
