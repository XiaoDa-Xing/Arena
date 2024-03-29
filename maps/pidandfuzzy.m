clear all;
close all;
clc;

%% 寻路部分
load('b2map.mat');
dilateMap=dilate2(mapdata);
dilateMap=border(dilateMap);
zhanshi(mapdata);

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
        if dilateMap(i,j) == 2
            plot(j-0.5,i-0.5,'rx');%在每一格是障碍物的地方画红色叉
        end
    end
end
hold on

path=Ax(obstacle,map,dilateMap');

len=length(path(:,1));

% for i=2:len-2
%     kangle1=atan2((path(i-1,2)-path(i,2)),(path(i-1,1)-path(i,1)));
%     kangle2=atan2((path(i,2)-path(i+1,2)),(path(i,1)-path(i+1,1)));
%     dkangle=changerad(kangle1-kangle2);
%     if dilateMap(path(i,2),path(i,1))==2 && abs(dkangle)>0.5
%         path(i)=(path(i+1)+path(i-1))/2;
%     end
% end

for i=2:len-2
    kangle1=atan2((path(i-1,2)-path(i,2)),(path(i-1,1)-path(i,1)));
    kangle2=atan2((path(i,2)-path(i+1,2)),(path(i,1)-path(i+1,1)));
    dkangle=changerad(kangle1-kangle2);%dkangle为负则向右转
    if path(i,2)==fix(path(i,2)) && path(i,1)==fix(path(i,1))
        if dilateMap(path(i,2),path(i,1))==2 && abs(dkangle)>0.7
            if abs(kangle2)==pi/2 && dilateMap(path(i,2),path(i,1)-1)==1 && dilateMap(path(i,2),path(i,1)+1)==1
                path(i)=path(i+2)+(path(i-1)-path(i+2))/3*2;
                path(i+1)=path(i+2)+(path(i-1)-path(i+2))/3;
            elseif abs(kangle1)==pi/2
                path(i)=path(i+1)+(path(i-2)-path(i+1))/3;
                path(i-1)=path(i+1)+(path(i-2)-path(i+1))/3*2;
            end
        end
    end
        
        
    
%     if dilateMap(path(i,2),path(i,1))==2 && abs(dkangle)>0.5
%         path(i)=path(i+1)+(path(i-2)-path(i+1))/3;
%         path(i-1)=path(i+1)+(path(i-2)-path(i+1))/3*2;
%     end
end

path=[path;map.start];


path=path-0.5;

if length(path(:,1))>=1
    %plot(path(:,1)-0.5,path(:,2)-0.5,'-c','LineWidth',2);
    plot(path(:,1),path(:,2),'-r','LineWidth',2);
end
hold on;

%% 控制部分
kp = 125;
ki = 0.3;
kd = 530;

fis=readfis('arenafuz.fis');

%最优路径的插值
pathin=zeros(9,2);
len=length(path(:,1));



for i=1:len-1
    k=10*i-9;
    for j=1:9
        pathin(j,1)=path(k,1)+j*(path(k+1,1)-path(k,1))/10;
        pathin(j,2)=path(k,2)+j*(path(k+1,2)-path(k,2))/10;
    end
    path=[path(1:k,:);pathin;path(k+1:end,:)];
end

intergral = 0;
last_error =0;
%now_state=[1.5 3.5 3.14/4+pi+pi+1.1];
now_state=[2 3 -0.03];

fuzflag=0;

for i=1:length(path)*0.5 
        
    %在点到最优路径的所有距离中找出最小值，即垂线距离
    d = path(:,1:2) - now_state(1:2);
    all_distance = d(:,1).^2 + d(:,2).^2;
    [~,index] = min(all_distance);             
    min_dx = now_state(1) - path(index,1);
    min_dy = now_state(2) - path(index,2);
    
    angle1=atan2((path(index-1,2)-path(index,2)),(path(index-1,1)-path(index,1)));
    angle2=atan2((path(index-2,2)-path(index-1,2)),(path(index-2,1)-path(index-1,1)));
    dangle1=changerad(now_state(3)-angle1);
    dangle2=changerad(now_state(3)-angle2);
    
%     if abs(changerad(dangle1))>0.03
%         flag1=1;
%     else
%         flag1=0;
%     end
%     
%     if abs(changerad(dangle2))>0.03
%         flag2=1;
%     else
%         flag2=0;
%     end
%     
%     ad=all_distance(index);
%     if all_distance(index)<0.05
%         flag3=1;
%     else
%         flag3=0;
%     end
%     
%     nh=now_state(3);
%     if  all_distance(index)<0.05 &&(abs(changerad(dangle1))>0.7 || abs(changerad(dangle2))>0.7)
%         flag=1;
%     else
%         flag=0;
%     end
    if  abs(dangle1)>0.35 || abs(dangle2)>0.35
        fuzflag=1;
    end
    
    %if  fuzflag==1 && (abs(changerad(dangle1))<0.03 || abs(changerad(dangle2))<0.03)
    if  fuzflag==1 && abs(dangle2)<0.03
        fuzflag=0;
        intergral = 0;
        last_error = 0;
    end
    
    if fuzflag==1
        action(1)=0;
        action(2) = evalfis(fis,dangle2);
        new_state = actionmodel(now_state,action);
        plot(new_state(1),new_state(2),'b*');
        now_state = new_state;
        continue;
    end
    

    error = (sin(now_state(3) - atan2(min_dy,min_dx))) * sqrt(min_dx*min_dx+min_dy*min_dy);
%   设计error的关键点：
%  1. error=f(点到直线的距离，角度偏差)，两个因素缺一不可
%  2. 要能满足：小车在最优路径的左边时，让其角度减小，从而右转；反之则反
%  该error的形式能将上述两点都满足

    %pid_value为控制量
    %TO_DO：增量式PID会不会好一点？要不要设积分环节的饱和限制？
    intergral = intergral + error;
    pid_value = kp*error + ki*intergral + kd*(error - last_error);
    last_error = error;

    %这里除100是为了让三个pid参数大100倍，好调一些
    action = [1, pid_value/100];
    new_state = actionmodel(now_state,action);

    plot(new_state(1),new_state(2),'b*');

    now_state = new_state;
end


























