function dilate1(obtainMap)
    dilateMap=zeros(50,50);
    
%     map=zeros(50,50);
%     map(2:49,2:49)=obtainMap(2:49,2:49);
    [x,y]=find(obtainMap(2:49,2:49)==1);
    x=x+1;
    y=y+1;
    [len,~]=size(x);
    for i=1:len
        dilateMap(x(i)-1:x(i)+1,y(i)-1:y(i)+1)=1;
    end
    
    [x,~]=find(obtainMap(2:49,1)==1);
    [len,~]=size(x);
    x=x+1;
    for i=1:len
        dilateMap(x(i)-1:x(i)+1,2)=1;
    end
    
    [x,~]=find(obtainMap(2:49,50)==1);
    [len,~]=size(x);
    x=x+1;
    for i=1:len
        dilateMap(x(i)-1:x(i)+1,49)=1;
    end
    
    [~,y]=find(obtainMap(1,2:49)==1);
    [~,len]=size(y);
    y=y+1;
    for i=1:len
        dilateMap(2,y(i)-1:y(i)+1)=1;
    end
    
    [~,y]=find(obtainMap(50,2:49)==1);
    [~,len]=size(y);
    y=y+1;
    for i=1:len
        dilateMap(49,y(i)-1:y(i)+1)=1;
    end
    
    if obtainMap(1,50)==1
        dilateMap(2,49)=1;
    end
    if obtainMap(1,1)==1
        dilateMap(2,2)=1;
    end
    if obtainMap(50,1)==1
        dilateMap(49,2)=1;
    end
    if obtainMap(50,50)==1
        dilateMap(49,49)=1;
    end

    dilateMap(1:50,1)=1;
    dilateMap(1:50,50)=1;
    dilateMap(1,1:50)=1;
    dilateMap(50,1:50)=1;

    dilateMap(48:50,41:43)=0;
    
    zhanshi(dilateMap);
end
                