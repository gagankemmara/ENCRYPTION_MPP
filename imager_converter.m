function IMAGE_CONVERTER_MODULE(RED,GREEN,BLUE)
   
     img = uint8(zeros(4, 4, 3));
     index=1;
     for i=1:4
         for j=1:4
             img(i,j,1)=RED(index);
             img(i,j,2)=GREEN(index);
             img(i,j,3)=BLUE(index);
             index=index+1;
         end
     end


% Show the image (it will be small, so we resize it)
imshow(imresize(img, 40, 'nearest'));
% Suppose 'img' is your 4x4x3 RGB image
% Save it as a PNG image
imwrite(img, 'Image.png');
end

