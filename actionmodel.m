%% 从主程序中解包出来的action变化模型、可以作为测试时计算action变化使用
%% 输入参数 (laststate,action) laststate=[x,y,h],action=[u,v]
%% 输出参数 state=[x,y,h] 下一时刻状态
function state=actionmodel(laststate,action)
%state=[x,y,h]
%action=[u,v]
satLevel=[1,0.5];%action限制
%st=0.3动作间隔时间
tspan=[0 0.3];

%对输入action进行限制处理
if(length(action)~=length(satLevel))
    action =-1;
    return;
end
for i=1:length(action)
    if(abs(action(i))>satLevel(i))
        action(i)=satLevel(i)*sign(action(i));
    end
end

h_last=laststate(3);
u=action(1);
v=action(2);

dx=u*cos(h_last);
dy=u*sin(h_last);
dh=v;

[~, state] = ode45(@(t, state)[dx;dy;dh], tspan, laststate);

x=state(end,1);
y=state(end,2);
h=state(end,3);

state=[x,y,h];

