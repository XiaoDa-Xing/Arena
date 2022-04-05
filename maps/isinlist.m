function [flag,id]=isinlist(pos,open,close)
%flag=1不在openlist和closelist
%flag=2在openlist
%flag=3在closelist
    if isempty(open)
        flag=1;
        id=[];
    
    else
        for i=1:length(open(:,1))
            if isequal(pos,open(i,:))
                flag=2;
                id=i;
                return;
            else
                flag=1;
                id=[];
            end
        end
    end
    
    for i=1:length(close(:,1))
        if isequal(pos,close(i,:))
            flag=3;
            id=[];
            return;
        end
    end

end