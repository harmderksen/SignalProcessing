%if ~exist('MLPFflag')
%    load 'Y:\Projects\ARDS_Private\Waveforms\10146_W000106858_2017-01-05.mat';
%    MLPFflag=1;
%end
[f,freq,tm]=rdsamp('challenge/2017/training/A00/A00016',[]);
%freq=ECG_Waveform_I.frequency;
%g=ECG_Waveform_I.wave;
%n=length(g);
%f=zeros(7,n);
%f(1,:)=g;
%f(2,:)=ECG_Waveform_II.wave;
%f(3,:)=ECG_Waveform_III.wave;
%f(4,:)=ECG_Waveform_V.wave;
%f(5,:)=ECG_Waveform_AVF.wave;
%f(6,:)=ECG_Waveform_AVL.wave;
%f(7,:)=ECG_Waveform_AVR.wave;
f=f';
n=length(f);
ss=4000;
for i=0:ss:n-ss
    window=[i+1:i+ss];
    g=f(1,window);
    u=FindRPeaks2(g,freq);
    u2=Rdetect(g,freq);
    h=zeros(1,ss);
    h2=zeros(1,ss);
    h(u)=1;
    h2(u2)=1;
    plot(g,'black');
    hold on;
    plot(g-2,'black');
    plot(h,'red');
    plot(h2-2,'blue');
    hold off;
    pause
end

