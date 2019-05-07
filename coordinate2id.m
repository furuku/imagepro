function ID=coordinate2id(x,y)
M=csvread('data01.txt');

D=((x - M(:,2)).^2 + (y - M(:,3)).^2).^0.5;
d_min=min(D);
k=find(D==d_min);
if(d_min< 100)
    [M(k,4) d_min];
else
    disp('noise')
end
ID=M(k,4);