function [neighbors]=eightneighor(refernceImage)
[row,col]=size(refernceImage);
for i=2:row-1
    for j=2:col-1
        neighbors{i,j}=[refernceImage(i-1,j), refernceImage(i,j-1),refernceImage(i+1,j),refernceImage(i,j+1),...
            refernceImage(i-1,j-1), refernceImage(i+1,j-1),refernceImage(i+1,j+1),refernceImage(i-1,j+1)];
    end
end
for i=1
    for j=2:col-1
        neighbors{i,j}=[refernceImage(i,j-1),refernceImage(i+1,j),refernceImage(i,j+1)];
    end
end
for i=row
    for j=2:col-1
        neighbors{i,j}=[refernceImage(i,j-1),refernceImage(i-1,j),refernceImage(i,j+1)];
    end
end
for i=2:row-1
    for j=1
        neighbors{i,j}=[refernceImage(i-1,j),refernceImage(i+1,j),refernceImage(i,j+1)];
    end
end
for i=2:row-1
    for j=col
        neighbors{i,j}=[refernceImage(i,j-1),refernceImage(i-1,j),refernceImage(i+1,j)];
    end
end
neighbors{1,1}=[ refernceImage(1,2),refernceImage(2,1)];
neighbors{1,col}=[refernceImage(1,511),refernceImage(2,512)];
neighbors{row,1}=[refernceImage(row,2),refernceImage(row-1,1)];
neighbors{row,col}=[refernceImage(row-1,col),refernceImage(row,col-1)];