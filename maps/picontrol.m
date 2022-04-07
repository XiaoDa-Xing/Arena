clear all;
close all;
clc;

kp=[];
ki=[];

load('test.mat');

curp=[2 3 0.835];

pathin=zeros(9,2);

% for i=1:59
%     k=10*i-9;
%     for j=1:9
%         pathin(j,1)=path(k,1)+j*(path(k+1,1)-path(k,1))/10;
%         pathin(j,2)=path(k,2)+j*(path(k+1,2)-path(k,2))/10;
%     end
%     path=[path(1:k,:);pathin;path(k+1:end,:)];
% end

plot(path(:,1),path(:,2),'r.');
hold on;

while 1
    
end