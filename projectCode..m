clc
clear all
close all
warning off

% create separate figure windows using imshow from series of files
files = dir('*.jpg');
for i = 1:numel(files)
   file = files(i);
   filename = fullfile(file.folder, file.name);

   disp(file.name);
   img = imread(filename);
   
   figure();imshow(img);

   %Modifying the background
   h = impoly(imgca,'closed',false);
   
   BW2 = createMask(h);
   figure();imshow(BW2);

   % Break down and mask the planes:
   r = img(:,:,1);
   g = img(:,:,2);
   b = img(:,:,3);
    
   r(~BW2) = 255;
   g(~BW2) = 255;
   b(~BW2) = 255;
    
   % Reconstruct the RGB image:
   upd_img = cat(3,r,g,b);
    
   % smoothing boundary 
   % useing bicubic interpolation function.
   I_bic = imresize(upd_img,5, 'bicubic');
    
   subplot(2,1,1);, imshow(img) 
   title('Actual image)')

    % display image after smooting
   subplot(2,1,2);, imshow(I_bic) 
   title('image after Background Removal )')

   %imwrite(I_bic,filename);


   disp("end");
end
