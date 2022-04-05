function hcost = H(m,goal)
    hcost=10*abs(m(1)-goal(1))+10*abs(m(2)-goal(2));
    %hcost=14*min(abs(m(1)-goal(1)),abs(m(2)-goal(2)))+10*min(abs(m(1)-goal(1))-abs(m(2)-goal(2)));
end