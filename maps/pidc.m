clear all;close all;clc;

kp = 9;
%ki = 0.01;
ki = 0.01;
kd = 30;

v = 1;
dt = 0.1;
L= 2.5;
curp=[2 3 3.14/4+0.5];

% x = 0:0.1:50;
% y = sin(x/5);
% path = [x' y'];
load('test.mat');

pathin=zeros(9,2);

for i=1:59
    k=10*i-9;
    for j=1:9
        pathin(j,1)=path(k,1)+j*(path(k+1,1)-path(k,1))/10;
        pathin(j,2)=path(k,2)+j*(path(k+1,2)-path(k,2))/10;
    end
    path=[path(1:k,:);pathin;path(k+1:end,:)];
end
        

plot(path(:,1),path(:,2),'r.');
hold on;


intergral = 0;
pre_err =0;
for i=1:length(path)
    
    d = path(:,1:2) - curp(1:2);
    dis = d(:,1).^2 + d(:,2).^2;
    [~,ind] = min(dis);                                     %找路径最近点索引
    
    dx = curp(1) - path(ind,1);
    dy = curp(2) - path(ind,2);
    
    e = (sin(curp(3) - atan2(dy,dx)))*sqrt(dx*dx+dy*dy);    %横向偏差作为测量
     
    intergral = intergral + e;
    u = kp*e + ki*intergral + kd*(e - pre_err);             %pid生成控制量，前轮转角
    pre_err = e;

    curp(1) = curp(1) + dt*v*cos(curp(3));
    curp(2) = curp(2) + dt*v*sin(curp(3));  
    curp(3) = curp(3) + dt*v*tan(u)/L;
  
    plot(curp(1),curp(2),'g.');
end

%axis equal;