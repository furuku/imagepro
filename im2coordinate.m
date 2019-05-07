function C=im2coordinate(fname)


    I=imread(fname);
    imshow(I);   

    imhsv=rgb2hsv(I);
    h = imhsv(:,:,1);
    s = imhsv(:,:,2);
    v = imhsv(:,:,3);
    close all;
    figure(1);
    subplot(2,2,1),imshow(I) ;
    subplot(2,2,2),imshow(h) ;
    subplot(2,2,3),imshow(s) ;
    subplot(2,2,4),imshow(v) ;

    figure(2);
    imf=(s>0.3) .* (s<0.8)  .* (h<0.2).*(h>0.12)  ; %,,,,,,
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
    imshow(I);

    L=bwlabel(imf,8);
    
    %break
    
    for i=1:max(max(L))
        [r, c]=find(L==i);
        x=min(c);  y=min(r);
        %text(x,y+25,num2str(size(r,1)),'color','r');
        
    end
    C=[];
    for i=1:max(max(L))
        [r, c]=find(L==i);
        x=min(c);  y=min(r);
        w=max(c)-x; h=max(r)-y;
        [w h];
        if((w>7 && w<30) && (h>7 && h<30) && (y>200))        %,,,,,,,
            e1=max([w h]); e2=min([w h]);
            %text(x,y-10,num2str(e1/e2),'color','r') %...........
            rectangle('position',[x y w h],'edgecolor','g');
            text(x,y-55,num2str(x),'color','y');
            text(x,y-25,num2str(y),'color','y');
            
            fileID = fopen('test.txt','w+t');      
            formatSpec = '%5d,%5d\n';
            fprintf(formatSpec,x,y);
            C=[C;x y];
        end
    end
            %text(x,y+25,num2str(size(r,1)),'color','r'); %.................
     