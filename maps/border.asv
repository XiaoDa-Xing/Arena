function bordermap=border(map)
    bordermap=map;
    next = [-1,1;...
            0,1;...
            1,1;...
            -1,0;...
            1,0;...
            -1,-1;...
            0,-1;...
            1,-1];
    
    for i=2:49
        for j=2:49
            if map(i,j)==1
                for k=1:8
                    if map(i+next(k,1),j+next(k,2))~=1
                        bordermap(i+next(k,1),j+next(k,2))=2;
                    else
                        continue;
                    end
                end
            end
            if i==2||j==2||i==49||j==49
                if map(i,j)==0
                    bordermap(i,j)=2;
                end
            end
        end
    end
    bordermap(48:50,41:43)=0;
end
