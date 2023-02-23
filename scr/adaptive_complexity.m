function  [acc,PE,COM0] = adaptive_complexity(subimage0,ADComplexity,referenceImageMAP,kernel_height,model)
[row,col]=size(subimage0);[row0,col0]=size(subimage0{1,1});
[Blocklocation]=Blocklocationdivid(row0,col0);
complexity={};
num=0;
for i=1:row
    for j=1:col
        coverImage=subimage0{i,j};
        orderImageblock=coverImage(:);
        [~,blockNum]=size(orderImageblock');
        [b,c]=sort(orderImageblock');
        
        orderImageblocklocation=Blocklocation(:);
        orderImageblocklocation=orderImageblocklocation';
        [coordinate11,~]=min([orderImageblocklocation{c(1,1)}(1),orderImageblocklocation{c(1,2)}(1)]);
        [coordinate12,~]=max([orderImageblocklocation{c(1,1)}(1),orderImageblocklocation{c(1,2)}(1)]);
        [coordinate21,~]=min([orderImageblocklocation{c(1,1)}(2),orderImageblocklocation{c(1,2)}(2)]);
        [coordinate22,~]=max([orderImageblocklocation{c(1,1)}(2),orderImageblocklocation{c(1,2)}(2)]);
        
        [coordinate31,~]=min([orderImageblocklocation{c(1,blockNum-1)}(1),orderImageblocklocation{c(1,blockNum)}(1)]);
        [coordinate32,~]=max([orderImageblocklocation{c(1,blockNum-1)}(1),orderImageblocklocation{c(1,blockNum)}(1)]);
        [coordinate41,~]=min([orderImageblocklocation{c(1,blockNum-1)}(2),orderImageblocklocation{c(1,blockNum)}(2)]);
        [coordinate42,~]=max([orderImageblocklocation{c(1,blockNum-1)}(2),orderImageblocklocation{c(1,blockNum)}(2)]);
        if i==1 || i==row || j==1 ||j==col
            map1=Inf*ones(row0,col0);
            map2=Inf*ones(row0,col0);
            for m=1:row0
                for n=1:col0
                    if m<=coordinate11+1&& m>=coordinate11-1 && n<=coordinate21+1 && n>=coordinate21-1
                        map1(m,n)=1;
                    end
                    if m<=coordinate12+1&& m>=coordinate12-1 && n<=coordinate22+1 && n>=coordinate22-1
                        map1(m,n)=1;
                    end
                    if m<=coordinate12 && m>=coordinate11 && n<=coordinate22 && n>=coordinate21
                        map1(m,n)=1;
                    end
                    
                    %%%%
                    if m<=coordinate31+1&& m>=coordinate31-1 && n<=coordinate41+1 && n>=coordinate41-1
                        map2(m,n)=1;
                    end
                    
                    if m<=coordinate32+1&& m>=coordinate32-1 && n<=coordinate42+1 && n>=coordinate42-1
                        map2(m,n)=1;
                    end
                    
                    if m<=coordinate32 && m>=coordinate31 && n<=coordinate42 && n>=coordinate41
                        map2(m,n)=1;
                    end
                end
            end
            
            complexity_area1=map1.*referenceImageMAP{i,j};
            complexity_area2=map2.*referenceImageMAP{i,j};
           
            num=num+1;
            predictionerror(num)=b(1,1)-b(1,2);
            complexity{num}=complexity_area1(:)';
            num=num+1;
            predictionerror(num)=b(1,blockNum)-b(1,blockNum-1);
            complexity{num}=complexity_area2(:)';
               
        else
            map1=Inf*ones(row0+2,col0+2);
            map2=Inf*ones(row0+2,col0+2);
            coordinate11=coordinate11+1;
            coordinate12=coordinate12+1;
            coordinate21=coordinate21+1;
            coordinate22=coordinate22+1;
            
            coordinate31=coordinate31+1;
            coordinate32=coordinate32+1;
            coordinate41=coordinate41+1;
            coordinate42=coordinate42+1;
            
            for m=1:row0+2
                for n=1:col0+2
                    if m<=coordinate11+1&& m>=coordinate11-1 && n<=coordinate21+1 && n>=coordinate21-1
                        map1(m,n)=1;
                    end
                    
                    if m<=coordinate12+1&& m>=coordinate12-1 && n<=coordinate22+1 && n>=coordinate22-1
                        map1(m,n)=1;
                    end
                    
                    if m<=coordinate12 && m>=coordinate11 && n<=coordinate22 && n>=coordinate21
                        map1(m,n)=1;
                    end
                    %%%%
                    if m<=coordinate31+1&& m>=coordinate31-1 && n<=coordinate41+1 && n>=coordinate41-1
                        map2(m,n)=1;
                    end
                    
                    if m<=coordinate32+1&& m>=coordinate32-1 && n<=coordinate42+1 && n>=coordinate42-1
                        map2(m,n)=1;
                    end
                    
                    if m<=coordinate32 && m>=coordinate31 && n<=coordinate42 && n>=coordinate41
                        map2(m,n)=1;
                    end
                end
            end
            complexity_area1=map1.*referenceImageMAP{i,j};
            complexity_area2=map2.*referenceImageMAP{i,j};
            
            
            num=num+1;
            predictionerror(num)=b(1,1)-b(1,2);
            complexity{num}=complexity_area1(:)';
            num=num+1;
            predictionerror(num)=b(1,blockNum)-b(1,blockNum-1);
            complexity{num}=complexity_area2(:)';
        end
        
        
    end
end
[~,numerror]=size(complexity);
COM={};
for i=1:numerror
    com=complexity{i};
    [~,numref]=size(com);
    flag=0;
    for j=1:numref
        if com(j)~=Inf && com(j)~=-Inf && ~isnan(com(j))
            flag=flag+1;
            COM{i}(flag)=com(j);
        end
    end
    [sorted,~]=sort(COM{i});
    [~,row]=size(sorted);
    if model==3
         COMPLEXITY3(i)=mean(sorted);
    else  
    COMPLEXITY2(i)=sorted(row)-sorted(1);
    COMPLEXITY3(i)=COMPLEXITY2(i)/row;
    end
end

if kernel_height==0
COMPLEXITY=1*COMPLEXITY3+ADComplexity*0;
elseif  kernel_height==3
COMPLEXITY=1*COMPLEXITY3+ADComplexity*0;
elseif kernel_height==5
COMPLEXITY=1*COMPLEXITY3+ADComplexity*0; 
end


[~,location]=sort(COMPLEXITY);
[~,a]=size(predictionerror);
for i=1: a
    predictionErrorSort(i,1) = predictionerror(1,location(1,i));
end

num=0;
for ratio=0.05:0.05:1
    num=num+1;
    selectednumber=floor(ratio * a);
    statistic=tabulate(predictionErrorSort(1:selectednumber,1));
    [raw_1,~]=find( statistic(:,1)==-1);
    [raw1,~]=find( statistic(:,1)==1);
    acc(num,1)=ratio;
    acc(num,2)=(statistic(raw_1,2)+ statistic(raw1,2))/selectednumber;
end
COM=COMPLEXITY';
COM0=COM/max(COM);
PE=predictionerror';