function [v ] = L1Proj(u,x,steps)
l1norm=sum(abs(u));
t=max(abs(u));
if l1norm<=x
    v=u;
else
    step=t/2;
    for j=1:steps
        l1norm=sum(max(abs(u)-t,0));
        if l1norm>x
            t=t+step;
        else
            t=t-step;
        end
        step=step/2;      
    end
    v=max(abs(u)-t,0).*sign(u);

end

end

