function complexity=deletmeddle(complexity)
flag=1;
while flag==1
table=tabulate(complexity);
[a,~]=size(table);
buffer=[];
for i=2:a-1
    if table(i,2)<=table(i+1,2) && table(i,2)<=table(i-1,2) && table(i,2)<100
        buffer(end+1)=i;
    end
end
[~,c]=size(buffer);

if c==0
    flag=0;
end

[b,~]=size(complexity);
for j=1:c
    comdel=table(buffer(1,j),1);
    comchange=table(buffer(1,j)-1,1);
    for i=1:b
        if complexity(i,1)==comdel
            complexity(i,1)= comchange;
        end
    end
end

end

