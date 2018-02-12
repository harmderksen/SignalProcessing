function [peak_signal] = MultiLeadPeakFilter(ecg,freq)
% function [peak_signal] = MultiLeadPeakFilter(ecg,freq)
% takes a multi-lead ecg and converts it to single lead signal
% that enhances the R-peaks
%
% ecg: d x n array where d is the number of leads
% freq: sampling frequency
% peak_signal: output
[m,n]=size(ecg);
peak_width=.05; % this value could be adjusted
s=floor(peak_width*freq);
peak_signal=sqrt(max(0,sum((ecg(:,s+1:end-s)-ecg(:,1:end-2*s)).*(ecg(:,s+1:end-s)-ecg(:,2*s+1:end)),1)));
peak_signal=[zeros(1,s),peak_signal,zeros(1,s)];
end

