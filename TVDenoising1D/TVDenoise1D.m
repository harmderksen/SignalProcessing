% function [a] =TVDenoise1D(c,order,x,delta)
% finds best l_2 approximation a of c, with the constraint that
% the absolute value of the d-fold integral of c-a is bounded by x, 
% where d='order'+2
%
% input: 
% c: input function (row vector)
% order: approximation has a continuous derivative of order 'order'
% 'order'=-1 gives total variation denoising
% x: higher values give more denoising
% delta: accuracy, number between 0 and 1, closer to 1 means more accurate
%
% output:
% a: denoised signal
%
% WARNING: this code is quite slow, but OK for experimenting

function [a] =TVDenoise1D(c,order,x,delta)
x=x/2^(order+2);
n=length(c);
e=zeros(1,n);
De=zeros(1,n);
u=0;
w=c;
if mod(order,2)==1
    w=(w-[0,w(1:end-1)])/2;
end
for i=0:floor(order/2)
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
    for i=0:floor(order/2)       
        De=(De-[0,De(1:end-1)])/2;
        De=(De-[De(2:end),0])/2;
    end
    z=c-De;
    u=sum(De.*z);
    w=z;
    if mod(order,2)==1
        w=(w-[0,w(1:end-1)])/2;
    end
    for i=0:floor(order/2)
        w=(w-[w(2:end),0])/2;
        w=(w-[0,w(1:end-1)])/2;
    end
end
a=c-De;  
end

