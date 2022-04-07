clear all;
close all;
clc;
load('test.mat');

%纯pid下几乎是最优参数，有一定容错空间，但也勿随意修改
kp = 125;
ki = 0.3;
kd = 500;

%最优路径的插值
pathin=zeros(9,2);
for i=1:59
    k=10*i-9;
    for j=1:9
        pathin(j,1)=path(k,1)+j*(path(k+1,1)-path(k,1))/10;
        pathin(j,2)=path(k,2)+j*(path(k+1,2)-path(k,2))/10;
    end
    path=[path(1:k,:);pathin;path(k+1:end,:)];
end

%这一层for循环是为了找参数
for k = 1:1
    intergral = 0;
    last_error =0;
    now_state=[1.5 3.5 3.14/3];
    kd =  500+30 *k;
    figure;
    plot(path(:,1),path(:,2),'r.');
    hold on;
    
    %不乘0.5的话，画出来的路径会过长，不知道为啥
    for i=1:length(path)*0.5 
        
        %在点到最优路径的所有距离中找出最小值，即垂线距离
        d = path(:,1:2) - now_state(1:2);
        all_distance = d(:,1).^2 + d(:,2).^2;
        [~,index] = min(all_distance);             
        min_dx = now_state(1) - path(index,1);
        min_dy = now_state(2) - path(index,2);
        
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
        
        plot(new_state(1),new_state(2),'g.');
        
        now_state = new_state;
    end
    
end


