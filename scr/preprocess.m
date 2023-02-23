function [complexity]=preprocess(complexity,proposed)
table=tabulate(complexity);
complexity=deletmeddle(complexity);
table1=tabulate(complexity);


[k,~]=size(table1);
[b,~]=size(complexity);
for i=1:k
    if sum(table1(1:i,3))>95
        flag=table1(i,1);
        break;
    end
end

for i=1:b
    if complexity(i,1)>flag
        complexity(i,1)=ceil(complexity(i,1)*10)/10;
    end
end
table2=tabulate(complexity);
%--------------------------------------

if proposed==1
    [k,~]=size(table2);
    [b,~]=size(complexity);
    for j=2:2:k
        flag=table2(j,1);
        flagnew=table2(j-1,1);
        for i=1:b
            if complexity(i,1)==flag
                complexity(i,1)=flagnew;
            end
        end
    end
   table3=tabulate(complexity);
   
   
   
    [k,~]=size(table3);
    [b,~]=size(complexity);
    for j=floor(k*(2/3)):2:k
        flag=table3(j,1);
        flagnew=table3(j-1,1);
        for i=1:b
            if complexity(i,1)==flag
                complexity(i,1)=flagnew;
            end
        end
    end
   table4=tabulate(complexity);
   
end

return;