function [recall1,precision1]=AP_sort(com1,pe)
[~,location]=sort(com1);
[counter,~]=size(com1);
for i=1: counter
    pe1(i,:) = pe(location(i),:);
end

statistic=tabulate(pe1(:,1));
[raw_1,~]=find( statistic(:,1)==-1);
[raw1,~]=find( statistic(:,1)==1);
P=(statistic(raw_1,2)+ statistic(raw1,2));
table=zeros(counter,2);
for i=1:counter
    if pe1(i,:) ==-1 || pe1(i,:) ==1
        table(i,1)=1;
    end
end


num=0;
for ratio=0.05:0.05:1
    recallNum=floor(ratio*P);
    num=num+1;
    accNum=0;
    for i=1:counter
        if pe1(i,:) ==-1 || pe1(i,:) ==1
            accNum=accNum+1;
        end
        if accNum>=recallNum 
            table(1:i,2)=ones(i,1);
            break;
        end
    end
    TP=sum(table(1:i,1));
    recall1(num,1)=recallNum/P;
    precision1(num,1)=TP/i;
end
buf=0;
for i=1:num-1
x=recall1(i+1)-recall1(i);
y=(precision1(i+1)+precision1(i))/2;
buf=buf+x*y;
end