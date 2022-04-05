function [openflag,id] = getopenflag( node,open )

    openflag = 0;
    id = 0;
    
    if  isempty(open)
        openflag = 0;

    else
        for i = 1:length(open(:,1))
           if isequal(node(1:2),open(i,1:2))
                openflag = 1;
                id = i;
                return;
           end 
        end
    end

end
