function [g] = ApproxStepFunction(f,width )
If_down=cumsum([zeros(1,width+1),f(1:end-width)]);
If=cumsum(f);
If_up=[If(width:end),ones(1,width)*If(end)];
Ig=TautString(If_up,If_down);
g=Ig(2:end)-Ig(1:end-1);
end

