classdef Policy < handle
    properties
        obtainMap
        dilateMap
        map
        endPosP
        path
        obstacles
        obstacle
        h
    end
    
    properties
        viewerP1
        viewerP2
        agentP
        agentOccupy
    end

    methods
        
        function self = Policy()
            self.obtainMap=zeros(50,50);
            self.map.XYMAX=50;
        end
        
        function action=action(self,observation)
            if observation.collide
                action=[-10,rand(1)-0.5];
            else
                action=[10,rand(1)-0.5];
            end
            action=[0,10];
            
            self.obstacle=[];
            
            self.obtainMap=double(observation.scanMap'|self.obtainMap);
            self.dilateMap=dilate(self.obtainMap);
            self.dilateMap=border(self.dilateMap);
            
            for i=1:50 %遍历map数组，是-1的画红叉
                for j=1:50
                    if self.dilateMap(i,j) == 1
                        self.obstacle=[self.obstacle;[j i]];
                        %plot(j-0.5,i-0.5,'rx');%在每一格是障碍物的地方画红色叉
                    end
                end
            end
            
            self.map.start=[round(observation.agent.x),round(observation.agent.y)];
            self.map.goal=[observation.endPos.x,observation.endPos.y];
            self.path=Ax(self.obstacle,self.map,self.dilateMap');
            
            if length(self.path(:,1))>=1
                %plot(close(:,2),close(:,1),'-c','LineWidth',2);
                delete(self.h);
                self.h=plot(self.viewerP1.ax,self.path(:,1)-0.5,self.path(:,2)-0.5,'-c','LineWidth',2);
                %plot(path(:,1)-0.5,path(:,2)-0.5,'rx');
            end
        end
        
        
        function reset(self,observation)
            self.obtainMap=observation.scanMap;
            self.viewerP1=Viewer(50,50);
            %self.viewerP2=Viewer(50,50);
            self.endPosP=observation.endPos;
            %self.endPosP=[observation.endPos.x,observation.endPos.y];
            %self.plotEndPosP(self.viewerP1.ax);
            self.plotMapP(self.viewerP1.ax);
            %self.plotEndPosP(self.viewerP2.ax);
            %self.plotMapP(self.viewerP2.ax);
            
            self.agentP=Agent(observation.startPos.x,observation.startPos.y,observation.startPos.heading,...
                8,0.58,2);
        end
        
        function render(self,observation)
            
            self.plotMapP(self.viewerP1.ax);
            self.agentP.x=observation.agent.x;
            self.agentP.y=observation.agent.y;
            self.agentP.h=observation.agent.h;
            self.agentP.plot(self.viewerP1.ax);
            self.agentOccupy=observation.agent.updateOccupyMap();
        end
        
        function plotEndPosP(self,handle)
            persistent hPlot;
            
            X=[self.endPosP.x self.endPosP.x+1 self.endPosP.x+1 self.endPosP.x self.endPosP.x];
            Y=[self.endPosP.y self.endPosP.y self.endPosP.y+1 self.endPosP.y+1 self.endPosP.y];
            
            X=[X self.endPosP.x self.endPosP.x+1 ];
            Y=[Y self.endPosP.y self.endPosP.y+1];
            
            X=[X self.endPosP.x+1 self.endPosP.x];
            Y=[Y self.endPosP.y self.endPosP.y+1];
            if isempty(hPlot)
                hPlot=plot(handle,X,Y,'r-','linewidth',3);
            else
                set(hPlot,'XData',X,'YData',Y);
            end
        end
        
        function plotMapP(self,handle)
            persistent fillHandle;
            %self.obtainmap=mapdata;
            [I,J]=find(self.obtainMap==1);
            self.obstacles=[J I]';
            len=size(self.obstacles,2);
            fillHandle=zeros(len,1);
            for i=1:len
                x=self.obstacles(1,i)-1;
                y=self.obstacles(2,i)-1;
                corners=[x,y;x+1,y;x+1,y+1;x,y+1];
                if fillHandle(i)==0
                    fillHandle(i)=fill(handle,corners(:,1),corners(:,2),'k');
                else
                    set(fillHandle(i),'XData',corners(:,1),'YData',corners(:,2));
                end
            end
        end
    end
end