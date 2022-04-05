function flag=isobstacle(pos,obstacle)
    for i=1:length(obstacle(:,1))
        if isequal(obstacle(i,:),pos)
            flag=true;
            return;
        end
    end
    flag=false;
end