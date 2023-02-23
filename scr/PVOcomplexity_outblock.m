function [accuracy,predictionErrorFinal,COM] = PVOcomplexity_outblock(subImage,subImage_out)

[a,~]=size(subImage);
[blocksize,~]=size(subImage{1});
counter=0;
for i=1:a
orderImageblock=subImage{i}(:);
[~,blockNum]=size(orderImageblock');
[b,~]=sort(orderImageblock');


subImage_outbuf=subImage_out{i};
buff=0;
for ii=1:blocksize+2
    jj=blocksize+1;
    diff=abs(subImage_outbuf(ii,jj)- subImage_outbuf(ii,jj+1));
    buff=buff+diff;
end
for ii=blocksize+1:blocksize+2
    for jj=1:blocksize
        diff=abs(subImage_outbuf(ii,jj)- subImage_outbuf(ii,jj+1));
        buff=buff+diff;
    end
end

for jj=1:blocksize+2
    ii=blocksize+1;
    diff=abs(subImage_outbuf(ii,jj)- subImage_outbuf(ii+1,jj));
    buff=buff+diff;
end
for ii=1:blocksize
    for jj=blocksize+1:blocksize+2
        diff=abs(subImage_outbuf(ii,jj)- subImage_outbuf(ii+1,jj));
        buff=buff+diff;
    end
end


predictionErrorMIN=b(1,1)-b(1,2);
predictionErrorMAX=b(1,blockNum)-b(1,blockNum-1);


 counter=counter+1;
 predictionErrorFinal(counter,1)=predictionErrorMIN;
 buffer(counter,1)=buff;
 counter=counter+1;
 predictionErrorFinal(counter,1)=predictionErrorMAX;
 buffer(counter,1)=buff;
end
[~,location]=sort(buffer);


for i=1: counter
  predictionErrorSort(i,:) = predictionErrorFinal(location(i),:);    
end
COM=buffer/max(buffer);

num=0;
for ratio=0.05:0.05:1
   num=num+1;
   selectednumber=floor(ratio * counter);
   statistic=tabulate(predictionErrorSort(1:selectednumber,1));
   [raw_1,~]=find( statistic(:,1)==-1);
   [raw1,~]=find( statistic(:,1)==1);
   accuracy(num,1)=ratio;
   accuracy(num,2)=(statistic(raw_1,2)+ statistic(raw1,2))/selectednumber;
end







