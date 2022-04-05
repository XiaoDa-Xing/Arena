function dilateMap=dilate(obtainMap)
    dilateMap=zeros(50,50);
    for i=2:49
        for j=2:49
            if obtainMap(i,j)==1
                dilateMap(i-1:i+1,j-1:j+1)=1;
            end
        end
    end
    
    for i=2:49
        if obtainMap(i,1)==1
            dilateMap(i-1:i+1,2)=1;
        end
    end
    for i=2:49
        if obtainMap(i,50)==1
            dilateMap(i-1:i+1,49)=1;
        end
    end
    for i=2:49
        if obtainMap(1,i)==1
            dilateMap(2,i-1:i+1)=1;
        end
    end
    for i=2:49
        if obtainMap(50,i)==1
            dilateMap(49,i-1:i+1)=1;
        end
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
    
    %zhanshi(dilateMap);
end
                