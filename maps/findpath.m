function path=findpath(close,start)
    id=1;
    path=[];
    while 1
        path=[path;close(id,1:2)];
        if isequal(close(id,1:2),start)
            break;
        end
        for i=1:length(close(:,1))
            if isequal(close(i,1:2),close(id,5:6))
                %close(id,:)=[];
                id=i;
                break;
            end
        end
    end
end
