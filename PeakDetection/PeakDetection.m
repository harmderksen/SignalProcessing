function [peak_list] = PeakDetection(ecg,freq )
% function [peak_list] = PeakDetection(ecg,freq )
%
% input:
% ecg : ecg wave form, row vector
% freq: sampling frequency
%
% output:
% peak_list: row vector, where the entries are the positions in the vector
% 'ecg' that correspond to the peaks (divide by 'freq' to get the times of
% the peaks in seconds
%
x=0; % x is the coordinate if the last peak

n=length(ecg);
ecg=conv(ecg,ones(1,round(freq*.02)),'same');
f=PeakFilter(ecg,freq); % apply the special filter that enhances peaks
peak_list=[];

t=[1:4*freq]/freq; 
shape=t.^2./(1+100*(t-.2).^4); % shape is the anticipation curve
% the value of f is scaled according to the last peak that appeared using
% the anticipation curve (for example, the next peak is more likely to come
% after .8s than after .2s.
ls=length(shape);

while x+.25*freq<n
    m=min(ls,n-x);
    [u,y]=max(shape(1:m).*f(x+1:x+m)); % scale f with shape, then find max
    x=x+y; % move x to the next peak
    
     if m==ls
        peak_list=[peak_list,x]; % add newly found peak to the list
     else
         if shape(y)*f(x)>shape(n-x+y)*(.3)
             peak_list=[peak_list,x]; % something ad-hoc for peak at the very end
         end
     end
         
end

plot(ecg);
hold on;
scatter(peak_list,ecg(peak_list));
hold off;
% make a nice picture, but one can comment this out if not wanted
end


    
  