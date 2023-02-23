function [accuracy,predictionErrorFinal,com] = PVOcomplexity(subImage)
[a,~]=size(subImage);
counter=0;
for i=1:a
    orderImageblock=subImage{i}(:);
    [~,blockNum]=size(orderImageblock');
    [b,~]=sort(orderImageblock');
    
    
    predictionErrorMIN=b(1,1)-b(1,2);
    predictionErrorMAX=b(1,blockNum)-b(1,blockNum-1);
    
    counter=counter+1;
    predictionErrorFinal(counter,1)=predictionErrorMIN;
    buffer(counter,1)=b(blockNum-1)-b(2);
    counter=counter+1;
    predictionErrorFinal(counter,1)=predictionErrorMAX;
    buffer(counter,1)=b(blockNum-1)-b(2);
    
end
[~,location]=sort(buffer);
com=buffer/max(buffer);

for i=1: counter
    predictionErrorSort(i,:) = predictionErrorFinal(location(i),:);
end


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

