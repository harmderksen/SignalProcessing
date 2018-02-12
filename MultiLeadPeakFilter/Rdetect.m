function [peaks] =Rdetect( ecg,freq )
n=length(ecg);
tm=([1:n]')/freq;
data=ecg'*100;
fileName='ecg_file';
Fs=freq;
wrsamp(tm,data,fileName,Fs);
gqrs(fileName);
peaks=rdann(fileName,'qrs');
end

