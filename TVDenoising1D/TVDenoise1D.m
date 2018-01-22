function [a] =TVDenoise1D(c,order,x,delta)
n=length(c);
e=zeros(1,n);
u=0;
w=c;
if mod(order,2)==1
    w=(w-[0,w(1:end-1)])/2;
end
for i=1:floor(order/2)
    w=(w-[w(2:end),0])/2;
    w=(w-[0,w(1:end-1)])/2;
end
while u<=delta*x*sum(abs(w))
    [u,delta,x,sum(abs(w))]
    e=e+w;
    e=min(abs(e),x).*sign(e);
    De=e;
    if mod(order,2)==1
        De=(De-[De(2:end),0])/2;
    end
    for i=1:floor(order/2)       
        De=(De-[0,De(1:end-1)])/2;
        De=(De-[De(2:end),0])/2;
    end
    z=c-De;
    u=sum(De.*z);
    w=z;
    if mod(order,2)==1
        w=(w-[0,w(1:end-1)])/2;
    end
    for i=1:floor(order/2)
        w=(w-[w(2:end),0])/2;
        w=(w-[0,w(1:end-1)])/2;
    end
end
a=c-De;  
end

