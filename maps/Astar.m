clc;
clear all;

load('cmap.mat');
dilateMap=dilate2(mapdata);
%zhanshi(mapdata);
dilateMap=border(dilateMap);
zhanshi(dilateMap);
hold on;

map.start=[2,3];
map.goal=[42,49];
map.XYMAX=50;

MAX_X=50;
MAX_Y=50;

obstacle=[];
for i=1:MAX_X %遍历map数组，是-1的画红叉
    for j=1:MAX_Y
        if dilateMap(i,j) == 1
            obstacle=[obstacle;[j i]];
            %plot(j-0.5,i-0.5,'rx');%在每一格是障碍物的地方画红色叉
        end
%         if dilateMap(i,j) == 2
%             plot(j-0.5,i-0.5,'rx');%在每一格是障碍物的地方画红色叉
%         end
    end
end
hold on

path=Ax(obstacle,map,dilateMap');

if length(path(:,1))>=1
    %plot(close(:,2),close(:,1),'-c','LineWidth',2);
    plot(path(:,1)-0.5,path(:,2)-0.5,'-c','LineWidth',2);
    %plot(path(:,1)-0.5,path(:,2)-0.5,'rx');
end