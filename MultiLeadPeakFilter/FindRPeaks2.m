function [peak_list] = FindRPeaks2(ecg,freq )
f=MultiLeadPeakFilter(ecg,freq);
n=length(f);
peak_list=[];
average_RR=.8*freq;
last_peak=0;
while last_peak+average_RR<n
    t=max(min(average_RR/2,3*freq),.3*freq);
    shape=[[[1:t]/t],exp(-[0:2*t]/2/t)];
    s=min(length(shape),n-last_peak);
    w=f(1,last_peak+1:last_peak+s).*shape(1:s);
    [a,b]=max(w);
    average_RR=.9*average_RR+.1*b;
    last_peak=last_peak+b;
    peak_list=[peak_list,last_peak];
end
g=zeros(1,n);
g(peak_list)=ones(1,length(peak_list));
ff=ecg(1,:);
ff=ff-mean(ff);
ff=ff/sqrt(mean(ff.^2));
plot([1:n],ff);
hold on;
scatter(peak_list,ff(peak_list));
hold off;
end
    
    
    
    


