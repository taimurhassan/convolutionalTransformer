% given the original image, its segmented result and the trained regression 
% model, this method returns the max number of instances 
function k = getCorrectInstance(img, oimg, net)
    L = bwlabel(img,8);
    k = -1;
    for j = 1:max(max(L))
    	[r,c] = find(L == j);
        
        if isempty(r) && isempty(c)
            continue;
        end
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);

        [r,c] = size(L);
        mask = zeros(r,c);
        mask(L == j) = 1;
        mask = uint8(mask).*oimg;
        img = imcrop(mask,[minX,minY,maxX-minX,maxY-minY]);
        if ismatrix(img)
        	img = cat(3,img,img,img);
        end
        YPredicted = predict(net,imresize(img,[224 224],'bilinear'));
        k = max(k,round(YPredicted));
	end        
end