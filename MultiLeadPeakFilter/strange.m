[f,Fs,tm]=rdsamp('mitdb/100',[]);
window=1:10000;
g=f(window,1);
wrsamp(tm(window,1),g,'ecg_file',Fs);
[g2,Fs,tm]=rdsamp('ecg_file');
wrsamp(tm(window,1),g*100,'ecg_file',Fs);
[g3,Fs,tm]=rdsamp('ecg_file');

