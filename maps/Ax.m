function path=Ax(obstacle,map,dmap)

    path=[];
    openlist=[];
    closelist=[];
    findflag=false;

    openlist=[map.start(1),map.start(2),0+H(map.start,map.goal),0,0,0];

    next = [-1,1,14;...
            0,1,10;...
            1,1,14;...
            -1,0,10;...
            1,0,10;...
            -1,-1,14;...
            0,-1,10;...
            1,-1,14];

    while ~findflag
        if isempty(openlist)
            disp('no path!!');
            return
        end

        [openflag,id]=getopenflag(map.goal,openlist);

        if openflag
            disp('get goal!!');
            closelist = [openlist(id,:);closelist];
            findflag=true;
            break;
        end

        minFinopen=find(openlist(:,3)==min(openlist(:,3)),1);

        closelist=[openlist(minFinopen,:);closelist]; 
        current=openlist(minFinopen,:);
        %plot(current(:,1),current(:,2),'rx');
        openlist(minFinopen,:)=[];

        for i=1:8
            nextPos=[current(1)+next(i,1),current(2)+next(i,2),0,0,0,0];

            if isobstacle(nextPos(1:2),obstacle)
                continue;
            end

            nextPos(4)=current(4)+next(i,3);
            
            if dmap(nextPos(1),nextPos(2))==2
                nextPos(3)=nextPos(4)+H(nextPos(1:2),map.goal)+50;
            else
                nextPos(3)=nextPos(4)+H(nextPos(1:2),map.goal);
            end
                

            [listflag,id]=isinlist(nextPos(1:2),openlist(:,1:2),closelist(:,1:2));
    %flag=1不在openlist和closelist
    %flag=2在openlist
    %flag=3在closelist
            if listflag == 3
                continue;
            elseif listflag == 1
                nextPos(5:6)=current(1:2);
                openlist=[openlist;nextPos];
                continue;
            else
                if nextPos(3)<openlist(id,3)
                    nextPos(5:6)=current(1:2);
                    openlist(id,:)=nextPos;
                    continue;
                end
            end
        end
    end
    %path=[closelist(:,1:2);openlist(:,1:2)];
    path=findpath(closelist,map.start);
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    