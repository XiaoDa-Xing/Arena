function zhanshi(map)
    fh=figure('Name','Game Arena','NumberTitle','off');
    h=50;
    w=50;
    fh.MenuBar='none';
    
    screenSize=get (0, 'ScreenSize');
    screenw=screenSize(3);
    screenh=screenSize(4);

    posw=screenw*1.5/4;
    posh=screenh*1.5/4;

    poswh=max(posw,posh);

    posx=screenw-poswh;
    posy=screenh-poswh;
    
    fh.Position =[posx posy poswh poswh];
    ax=axes('Position',[0.05 0.05 0.9 0.9],'Box','on');
    
    ax.YTick = 0:10:h;
    ax.XTick = 0:10:w;
    ax.FontSize = 12;
    ax.XLimMode='manual';
    ax.YLimMode='manual';
    ax.XLim=[0 w];
    ax.YLim=[0 h];       
    hold on;
    
    persistent fillHandle;
    %self.obtainmap=mapdata;
    [I,J]=find(map==1);
    obstacles=[J I]';
    len=size(obstacles,2);
    fillHandle=zeros(len,1);
    for i=1:len
        x=obstacles(1,i)-1;
        y=obstacles(2,i)-1;
        corners=[x,y;x+1,y;x+1,y+1;x,y+1];
        if fillHandle(i)==0
            fillHandle(i)=fill(ax,corners(:,1),corners(:,2),'k');
        else
            set(fillHandle(i),'XData',corners(:,1),'YData',corners(:,2));
        end
    end
end