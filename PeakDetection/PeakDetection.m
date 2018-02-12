function [peak_list] = PeakDetection(ecg,freq )
f=PeakFilter(ecg,freq);
x=0;
n=length(f);
peak_list=[];
    t0=round(.4*freq);
    t1=round(.7*freq);
    t2=round(1.1*freq);
    t3=round(1.5*freq);
    shape=[zeros(1,t0),[1:t1-t0]/(t1-t0)*8,8-[1:t2-t1]/(t2-t1)*7,1-[1:t3-t2]/(t3-t2)];
    shape=cumsum(shape);
    shape=max(shape)-shape;
    shape=shape./max(shape);
    t4=round(.4*freq);
    shape(1:t4)=([1:t4]/t4).^4;
    ls=length(shape);
while x+.25*freq<n
    m=min(ls,n-x);
    [u,y]=max(shape(1:m).*f(x+1:x+m));
     x=x+y
     if m==ls
        peak_list=[peak_list,x];
     else
         if shape(y)*f(x)>shape(n-x+y)*(.3)
             peak_list=[peak_list,x];
         end
     end
         
end
plot(ecg);
hold on;
scatter(peak_list,ecg(peak_list));
hold off;
end


    
  