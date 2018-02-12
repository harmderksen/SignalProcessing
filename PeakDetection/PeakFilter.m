function [peak_signal_score] = PeakFilter(ecg,freq)
% function [peak_signal] =PeakFilter(ecg,freq)
% takes a multi-lead ecg and converts it to single lead signal
% that enhances the R-peaks
%
% ecg: d x n array where d is the number of leads
% freq: sampling frequency
% peak_signal: output

% parameters that can be adjusted:


peak_width=.05; 
% width of QRS-complex is roughly 2*.05=.1s

window_width=1; 
% width of window used for smoothing (in sec)

[m,n]=size(ecg);
ww=floor(window_width*freq);
window=ones(1,ww);
u=ones(1,n);
pw=floor(peak_width*freq);
peak_signal=sqrt(max(0,(ecg(:,pw+1:end-pw)-ecg(:,1:end-2*pw)).*(ecg(:,pw+1:end-pw)-ecg(:,2*pw+1:end))));
peak_signal=[zeros(1,pw),peak_signal,zeros(1,pw)];
peak_signal_smooth=conv(peak_signal,window,'same');
peak_signal_smooth=conv(peak_signal_smooth,window,'same');
peak_signal_smooth=conv(peak_signal_smooth,window,'same');
u_smooth=conv(u,window,'same');
u_smooth=conv(u_smooth,window,'same');
u_smooth=conv(u_smooth,window,'same');
peak_signal_smooth=peak_signal_smooth./u_smooth;
peak_signal_normal=peak_signal./peak_signal_smooth;
t1=(peak_signal_normal>27);
t2=(1-t1).*(peak_signal_normal>70/9);
t3=1-t1-t2;
peak_signal_score=t1+t2.*(peak_signal_normal-7)/20+t3.*(peak_signal_normal)/200;
end

