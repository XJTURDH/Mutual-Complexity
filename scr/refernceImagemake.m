function [refernceImage]=refernceImagemake(subimage0,coverImage0)
[row,col]=size(subimage0);
refernceImage=zeros(512,512);
for i=1:row
    for j=1:col
        coverImage=subimage0{i,j};
        [row0,col0]=size(coverImage);
        orderImageblock=coverImage(:);
        [~,blockNum]=size(orderImageblock');
        [b,c]=sort(orderImageblock');
        b(1)=-Inf;
        b(blockNum)=Inf;
        for k=1:blockNum
            CorderImageblock(c(k))=b(k);
        end
        CorderImageblock=CorderImageblock';
        subimage1{i,j}=reshape(CorderImageblock,row0,col0);
    end
end

maxSubimageindexwidth=(floor(512/row0)-2)*row0+1;
maxSubimageindexheight=(floor(512/col0)-2)*col0+1;
for i=1:row0:maxSubimageindexwidth
    for  j=1:col0:maxSubimageindexheight
        ii=ceil(i/row0);
        jj=ceil(j/col0);
        refernceImage(i:i+row0-1,j:j+col0-1) = subimage1{ii,jj};
    end
end
row=maxSubimageindexwidth+row0;
col=maxSubimageindexheight+col0;

refernceImage(row:512,:)=coverImage0(row:512,:);
refernceImage(:,col:512)=coverImage0(:,col:512);

