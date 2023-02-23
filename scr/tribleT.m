function [PR]=tribleT(com0,com1,com2,pe)

statistic=tabulate(pe(:,1));
[counter,~]=size(pe);
[raw_1,~]=find( statistic(:,1)==-1);
[raw1,~]=find( statistic(:,1)==1);
accNum=(statistic(raw_1,2)+ statistic(raw1,2));

s1=tabulate(com0(:,1));
s2=tabulate(com1(:,1));
s3=tabulate(com2(:,1));
[num1,~]=size(s1);
[num2,~]=size(s2);
[num3,~]=size(s3);

pee=zeros(num1,num2,num3,2);
for i=1:counter
    row=find(s1(:,1)==com0(i,1));
    col=find(s2(:,1)==com1(i,1));
    high=find(s3(:,1)==com2(i,1));
    if pe(i,1)==1 || pe(i,1)==-1
        pee(row,col,high,1)=pee(row,col,high,1)+1;
    else
        pee(row,col,high,2)=pee(row,col,high,2)+1;
    end
end

N=0;
for n1=1:num1
    for n2=1:num2
        for n3= 1:num3
            N=N+1;
            T1=s1(n1,1);
            T2=s2(n2,1);
            T3=s3(n3,1);
            
            pt=sum(sum(sum(pee(1:n1,1:n2,1:n3,1))));
            nt=sum(sum(sum(pee(1:n1,1:n2,1:n3,2))));
            all=pt+nt;
            precision=pt/all;
            recall=pt/accNum;
            sppr=all/counter;
            table(N,:)=[T1,T2,T3,precision,recall,sppr]; % precision ， recall
        end
    end
end


num=0;
for recallrate=0.05:0.05:1
    num=num+1;
    precision_buffer=0;
    recall_buffer=0;
    for i=1:N
        if recallrate<=table(i,5) && recallrate+0.1>=table(i,5)
            if precision_buffer<table(i,4)
                precision_buffer=table(i,4);
                recall_buffer=table(i,5);
                I=i;
            end
        end
    end
    
    T1=table(I,1);
    T2=table(I,2);
    T3=table(I,3);
    
    ptfinal=ceil(recallrate*accNum);
    nt=0;
    pt=0;
    for i=1:counter
        if com0(i,1)<=T1 && com1(i,1)<=T2 && com2(i,1)<=T3
            if pe(i,1)==1 || pe(i,1)==-1
                pt=pt+1;
            else
                nt=nt+1;
            end
            if pt==ptfinal
                break;
            end
        end
    end
    all=pt+nt;
    precision=pt/all;
    
    PR(num,1)=recallrate;
    PR(num,2)=precision;
end

end

