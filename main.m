clc,
close all,
clear all,

%global x y

for k = 1:10
close all;
C{k}.xy=[];
C{k}.id=[];
    C{k}.xy=im2coordinate(sprintf('b%04d.jpeg',k));
     [r c]=size(C{k}.xy);
     for(i=1:r)
         C{k}.id=[C{k}.id; coordinate2id(C{k}.xy(i,1),C{k}.xy(i,2))];
     end
       
    drawnow();
end
   %{
    I{k}=imread(sprintf('b%04d.png',k));
    imshow(I{k});   

    imhsv=rgb2hsv(I{k});
    h = imhsv(:,:,1);
    s = imhsv(:,:,2);
    v = imhsv(:,:,3);
    close all;
    figure(1);
    subplot(2,2,1),imshow(I{k}) ;
    subplot(2,2,2),imshow(h) ;
    subplot(2,2,3),imshow(s) ;
    subplot(2,2,4),imshow(v) ;

    figure(2);
    imf=(s>0.2) .* (s<0.7)  .* (h<0.2).*(h>0.12)  ; %,,,,,,
    imshow(imf);

% Convert to BW
    threshold = graythresh(imf);
    BW=im2bw(imf,threshold);
    CC = bwconncomp(BW);
    L = labelmatrix(CC);

    RGB = label2rgb(L);
    figure
    imshow(RGB)

    figure(4);
    imshow(I{k});

    L=bwlabel(imf,8);
    
    %break
    
    for i=1:max(max(L))
        [r, I{i}]=find(L==i);
        x=min(I{i});  y=min(r);
        %text(x,y+25,num2str(size(r,1)),'color','r');
        
    end

    for i=1:max(max(L))
        [r, I{i}]=find(L==i);
        x=min(I{i});  y=min(r);
        w=max(I{i})-x; h=max(r)-y;
        [w h];
        if((w>5) && (h>5))        %,,,,,,,
            e1=max([w h]); e2=min([w h]);
            %text(x,y-10,num2str(e1/e2),'color','r') %...........
            rectangle('position',[x y w h],'edgecolor','g');
            %text(x,y+25,num2str(x),'color','y');
            %text(x,y-25,num2str(y),'color','y');
            
            fileID = fopen('test.txt','w+t');      
            formatSpec = '%5d,%5d\n';
            fprintf(formatSpec,x,y);
                      
            %text(x,y+25,num2str(size(r,1)),'color','r'); %.................
        end
    end
    
    %}
%end
   
     
     
     
 
 
 
 
 
 
 
 
 
