% function [a] =Deconvolution(c,f,x,delta)
function [e] =Deconvolution(c,f,x,delta)
f=f./sqrt(sum(f.^2))/2;
n=length(c);
frev=f(end:-1:1);
e=zeros(1,n);
De=zeros(1,n);
u=0;
w=conv(c,frev,'same');
while u<=delta*x*max(abs(w))
    u/delta/x/max(abs(w))
    e=e+w;
    e=L1Proj(e,x,30);
    De=conv(e,f,'same');
    z=c-De;
    u=sum(De.*z);
    w=conv(z,frev,'same');
end
a=c-De;  
end

