function [peak_signal_score] = PeakFilter(ecg,freq)
% function [peak_signal] =PeakFilter(ecg,freq)
% takes an ecg and converts it to a signal
% that enhances the R-peaks
%
% input:
% ecg: ecg wave form, row vector
% freq: sampling frequency
%
% output
% peak_signal: filtered signal

% parameters that can be adjusted:
peak_width=.035; 
% width of (part of) QRS-complex is roughly 2*.035=.7s
% used to differentiate between QRS complex and T/P waves.

window_width=1; 
% width of window used for smoothing (in sec)

[m,n]=size(ecg);
ww=floor(window_width*freq);
window=ones(1,ww);
u=ones(1,n);
pw=floor(peak_width*freq);
peak_signal=sqrt(max(0,(ecg(:,pw+1:end-pw)-ecg(:,1:end-2*pw)).*(ecg(:,pw+1:end-pw)-ecg(:,2*pw+1:end)))); %we apply a filter

% smoothing:
peak_signal=[zeros(1,pw),peak_signal,zeros(1,pw)];
peak_signal_smooth=conv(peak_signal,window,'same');
peak_signal_smooth=conv(peak_signal_smooth,window,'same');
peak_signal_smooth=conv(peak_signal_smooth,window,'same');
u_smooth=conv(u,window,'same');
u_smooth=conv(u_smooth,window,'same');
u_smooth=conv(u_smooth,window,'same');
peak_signal_smooth=peak_signal_smooth./u_smooth;
peak_signal_normal=peak_signal./peak_signal_smooth; % normalized signal

t1=(peak_signal_normal>27);
t2=(1-t1).*(peak_signal_normal>70/9);
t3=1-t1-t2;
peak_signal_score=t1+t2.*(peak_signal_normal-7)/20+t3.*(peak_signal_normal)/200; % we apply another filter
end

