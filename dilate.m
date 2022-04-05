function dilateMap=dilate(obtainMap)
    dilateMap=zeros(50,50);
    for i=1:50
        for j=1:50
            if obtainMap(i,j)==1
                if i>1 && i<50 && j>1 && j<50
                    dilateMap(i-1:i+1,j-1:j+1)=1;
                
                elseif i==1 && j>1 && j<50
                    dilateMap(2,j-1:j+1)=1;
                
                elseif i==50 && j>1 && j<50
                    dilateMap(49,j-1:j+1)=1;
                
                elseif i>1 && i<50 && j==1
                    dilateMap(i-1:i+1,2)=1;
                
                elseif i>1 && i<50 && j==50
                    dilateMap(i-1:i+1,49)=1;
                
                elseif i==1 && j==1
                    dilateMap(2,2)=1;
                    
                elseif i==1 && j==50
                    dilateMap(2,49)=1;
                
                elseif i==50 && j==1
                    dilateMap(49,2)=1;
                
                elseif i==50 && j==50
                    dilateMap(49,49)=1;
                end
            end
        end
    end

    dilateMap(1:50,1)=1;
    dilateMap(1:50,50)=1;
    dilateMap(1,1:50)=1;
    dilateMap(50,1:50)=1;
    
    dilateMap(48:50,41:43)=0;
    
    %zhanshi(dilateMap);
end
                