close all;
clear all;
clc;
image = imread('../data/4.2.04.tiff');
[~,~,channel]=size(image);
if channel>1
    coverImage = double(rgb2gray(image));
else
    coverImage = double((image));
end
[A,B]=size(image);
x=0;
for sizeSubimageheight= 3
    sizeSubimagewidth= sizeSubimageheight;
    x=x+1;
    line{x,1}=sizeSubimagewidth;
    subImage={};subImage0={};
    
    maxSubimageindexwidth=(floor(512/sizeSubimagewidth)-2)*sizeSubimagewidth+1;
    maxSubimageindexheight=(floor(512/sizeSubimageheight)-2)*sizeSubimageheight+1;
    subimageNum=0;
    for i=1:sizeSubimagewidth:maxSubimageindexwidth
        for  j=1:sizeSubimageheight:maxSubimageindexheight
            subimageNum=subimageNum+1;
            subImage(subimageNum,:) = {coverImage(i:i+sizeSubimagewidth-1,j:j+sizeSubimageheight-1)};
            subImage_out(subimageNum,:) = {coverImage(i:i+sizeSubimagewidth-1+2,j:j+sizeSubimageheight-1+2)};           
            ii=ceil(i/sizeSubimagewidth);
            jj=ceil(j/sizeSubimageheight);
            subImage_s(ii,jj) = {coverImage(i:i+sizeSubimagewidth-1,j:j+sizeSubimageheight-1)};
        end
    end
    [referenceImage]=refernceImagemake(subImage_s,coverImage);
    [neighbors]=eightneighor(referenceImage);
    
    [acc0,pe0,com0] = PVOcomplexity(subImage);
    [acc1,pe1,com1] = PVOcomplexity_outblock(subImage,subImage_out);
    for i=1:sizeSubimagewidth:maxSubimageindexwidth
        for  j=1:sizeSubimageheight:maxSubimageindexheight
            ii=ceil(i/sizeSubimagewidth);
            jj=ceil(j/sizeSubimageheight);
            if i==1|| j==1||i==maxSubimageindexwidth||j==maxSubimageindexheight
                referenceImageMAP(ii,jj) = { referenceImage(i:i+sizeSubimagewidth-1,j:j+sizeSubimageheight-1)};
            else
                referenceImageMAP(ii,jj) = { referenceImage(i-2:i+sizeSubimagewidth+1,j-2:j+sizeSubimageheight+1)};
            end          
        end
    end
    [acc2,pe2,com2] = neighbor_complexity_12(subImage_s,0,referenceImageMAP,0,0);
    
    %% Combination    
    [com0_pro]=preprocess(com0,0);
    [com1_pro]=preprocess(com1,1);
    [com2_pro]=preprocess(com2,1);
    [PR]=tribleT(com0_pro,com1_pro,com2_pro,pe2);
    PRcurve(com0,PR,pe2,sizeSubimageheight);
end

