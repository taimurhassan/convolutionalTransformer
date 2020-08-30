clc
clear all 
close all

% change the paths accordingly as per your system location
pn= 'C:\tcsvt\testingDataset\segmentation_results3\';
pn2 = 'C:\tcsvt\testingDataset\test_images\';

ext_img = [pn '*.png'];
a = dir(ext_img);
nfile = length(a);

knife1 = [183 244 155];
knife2 = [204 47 7];
knife3 = [31 133 226];
gun1 = [207 248 132];
gun2 = [222 181 51];
gun3 = [244 104 161];
wrench1 = [144 71 111];

for i=1:nfile
    fn = a(i).name; 
    im = imread([pn fn]);
    im2 = imread([pn2 fn]);
    
    [r,c,ch] = size(im);
    
    knife1M = zeros(r,c);
    knife2M = zeros(r,c);
    knife3M = zeros(r,c);
    gun1M = zeros(r,c);
    gun2M = zeros(r,c);
    gun3M = zeros(r,c);
    wrench1M = zeros(r,c);
    
    isK1 = false;
    isK2 = false;
    isK3 = false;
    isG1 = false;
    isG2 = false;
    isG3 = false;
    isW1 = false;
    for k = 1:r
        for j = 1:c
            if im(k,j,1) == knife1(1) && im(k,j,2) == knife1(2) && im(k,j,3) == knife1(3)
                knife1M(k,j) = 1;
                isK1 = true;
            end
            
            if im(k,j,1) == knife2(1) && im(k,j,2) == knife2(2) && im(k,j,3) == knife2(3)
                knife2M(k,j) = 1;
                isK2 = true;
            end
            
            if im(k,j,1) == knife3(1) && im(k,j,2) == knife3(2) && im(k,j,3) == knife3(3)
                knife3M(k,j) = 1;
                isK3 = true;
            end
            
            if im(k,j,1) == gun1(1) && im(k,j,2) == gun1(2) && im(k,j,3) == gun1(3)
                gun1M(k,j) = 1;
                isG1 = true;
            end
            
            if im(k,j,1) == gun2(1) && im(k,j,2) == gun2(2) && im(k,j,3) == gun2(3)
                gun2M(k,j) = 1;
                isG2 = true;
            end
            
            if im(k,j,1) == gun3(1) && im(k,j,2) == gun3(2) && im(k,j,3) == gun3(3)
                gun3M(k,j) = 1;
                isG3 = true;
            end
            
            if im(k,j,1) == wrench1(1) && im(k,j,2) == wrench1(2) && im(k,j,3) == wrench1(3)
                wrench1M(k,j) = 1;
                isW1 = true;
            end
        end
    end
    
    knife1M = imfill(bwareaopen(logical(knife1M),500),'holes');
    knife2M = imfill(bwareaopen(logical(knife2M),500),'holes');
    knife3M = imfill(bwareaopen(logical(knife3M),500),'holes');
    gun1M = imfill(bwareaopen(logical(gun1M),500),'holes');
    gun2M = imfill(bwareaopen(logical(gun2M),500),'holes');
    gun3M = imfill(bwareaopen(logical(gun3M),500),'holes');
    wrench1M = imfill(bwareaopen(logical(wrench1M),500),'holes');
                
    if isK1
        L = bwlabel(knife1M,8);
        for j = 1:max(max(L))
            [r,c] = find(L == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);
            
            mask = zeros(size(knife1M));
            mask(L == j) = 1;
            mask = uint8(mask).*im2;
            mask = imcrop(mask,[minX,minY,maxX-minX,maxY-minY]);
            if ismatrix(mask)
                mask = cat(3,mask,mask,mask);
            end
            imwrite(imresize(mask,[size(mask(:,:,1))],'bilinear'),[pn '\Resized\I_' num2str(rand(1)) fn],'PNG');
        end
    end
    
    if isK2
        L = bwlabel(knife2M,8);
        for j = 1:max(max(L))
            [r,c] = find(L == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            mask = zeros(size(knife2M));
            mask(L == j) = 1;
            mask = uint8(mask).*im2;
            mask = imcrop(mask,[minX,minY,maxX-minX,maxY-minY]);
            if ismatrix(mask)
                mask = cat(3,mask,mask,mask);
            end
            imwrite(imresize(mask,[size(mask(:,:,1))],'bilinear'),[pn '\Resized\I_' num2str(rand(1)) fn],'PNG');
        end
    end
    
    if isK3
        L = bwlabel(knife3M,8);
        for j = 1:max(max(L))
            [r,c] = find(L == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            mask = zeros(size(knife3M));
            mask(L == j) = 1;
            mask = uint8(mask).*im2;
            mask = imcrop(mask,[minX,minY,maxX-minX,maxY-minY]);
            if ismatrix(mask)
                mask = cat(3,mask,mask,mask);
            end
            imwrite(imresize(mask,[size(mask(:,:,1))],'bilinear'),[pn '\Resized\I_' num2str(rand(1)) fn],'PNG');
        end
    end
    
    if isG1 
        L = bwlabel(gun1M,8);
        for j = 1:max(max(L))
            [r,c] = find(L == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            mask = zeros(size(gun1M));
            mask(L == j) = 1;
            mask = uint8(mask).*im2;
            mask = imcrop(mask,[minX,minY,maxX-minX,maxY-minY]);
            if ismatrix(mask)
                mask = cat(3,mask,mask,mask);
            end
            imwrite(imresize(mask,[size(mask(:,:,1))],'bilinear'),[pn '\Resized\I_' num2str(rand(1)) fn],'PNG');
        end
    end
    
    if isG2
        L = bwlabel(gun2M,8);
        for j = 1:max(max(L))
            [r,c] = find(L == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            mask = zeros(size(gun2M));
            mask(L == j) = 1;
            mask = uint8(mask).*im2;
            mask = imcrop(mask,[minX,minY,maxX-minX,maxY-minY]);
            if ismatrix(mask)
                mask = cat(3,mask,mask,mask);
            end
            imwrite(imresize(mask,[size(mask(:,:,1))],'bilinear'),[pn '\Resized\I_' num2str(rand(1)) fn],'PNG');
        end
    end
    
    if isG3
        L = bwlabel(gun3M,8);
        for j = 1:max(max(L))
            [r,c] = find(L == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            mask = zeros(size(gun3M));
            mask(L == j) = 1;
            mask = uint8(mask).*im2;
            mask = imcrop(mask,[minX,minY,maxX-minX,maxY-minY]);
            if ismatrix(mask)
                mask = cat(3,mask,mask,mask);
            end
            imwrite(imresize(mask,[size(mask(:,:,1))],'bilinear'),[pn '\Resized\I_' num2str(rand(1)) fn],'PNG');
        end
    end
    
    if isW1
        L = bwlabel(wrench1M,8);
        for j = 1:max(max(L))
            [r,c] = find(L == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            mask = zeros(size(wrench1M));
            mask(L == j) = 1;
            mask = uint8(mask).*im2;
            mask = imcrop(mask,[minX,minY,maxX-minX,maxY-minY]);
            if ismatrix(mask)
                mask = cat(3,mask,mask,mask);
            end
            imwrite(imresize(mask,[size(mask(:,:,1))],'bilinear'),[pn '\Resized\I_' num2str(rand(1)) fn],'PNG');
        end
    end
end