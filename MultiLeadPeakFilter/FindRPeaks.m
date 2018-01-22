function [peaks] = FindRPeaks(ecg,freq )
f=MultiLeadPeakFilter(ecg,freq);
n=length(f);
half_time=1;
s=2^(-1/half_time/freq);
f_left=zeros(1,n);
f_left(1)=f(1);
for j=2:n
    f_left(j)=max(s*f_left(j-1),f(j));
end
f_right(n)=f(n);
for j=n-1:-1:1
    f_right(j)=max(s*f_right(j+1),f(j));
end
f_max=max(f_left,f_right);
peaks=find(f>=f_max);
end

