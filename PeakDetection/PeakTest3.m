beat_list={'.','N','L','R','A','a','J','S','V','F','e','j','E','/','f'};
s=length(beat_list);
h=[];
file_list={'mitdb/100','mitdb/101','mitdb/103','mitdb/105', ...
    'mitdb/106','mitdb/108','mitdb/109','mitdb/111','mitdb/112','mitdb/113','mitdb/114', ...
    'mitdb/115','mitdb/116','mitdb/117','mitdb/118','mitdb/119','mitdb/121','mitdb/122','mitdb/123', ...
    'mitdb/124','mitdb/200','mitdb/201','mitdb/202','mitdb/203','mitdb/205','mitdb/207','mitdb/208', ...
     'mitdb/209','mitdb/210','mitdb/201','mitdb/212','mitdb/213','mitdb/214','mitdb/215', ...
      'mitdb/219','mitdb/220','mitdb/221','mitdb/222','mitdb/223','mitdb/228','mitdb/230','mitdb/231', ...
       'mitdb/232','mitdb/233','mitdb/234'};

%file_list={'mitdb/203','mitdb/208','mitdb/207','mitdb/228','mitdb/232'};

t=length(file_list);
u=[];
    total_trueP=0;
    total_falseP=0;
    total_falseN=0;
for j=1:t
    trueP=0;
    falseP=0;
    falseN=0;
    h=[];
    name=file_list{j}
    [ann,anntype,subtype,chan,num,comments]=rdann(name,'atr');
    [tm,f]=rdsamp(name);
    for i=1:s
        x=find(anntype==beat_list{i});
        h=[h,ann(x)'];
    end
    h=sort(h);
    [f,freq,tm]=rdsamp(name,[]);
    f=f(:,1)';
    g=PeakDetection(f,360);
    number_predicted_peaks=length(g);
    number_peaks=length(h);
    [a,b]=sort([g,h]);
    la=length(a);
    for i=1:la
        if i==1
            q=a(2)-a(1);
        elseif i==la
            q=a(la)-a(la-1);
        else
            q=min(a(i)-a(i-1),a(i+1)-a(i));
        end
        if q<.05*freq
            if b(i)<=number_predicted_peaks
                trueP=trueP+1;
            end
        else
            if b(i)<=number_predicted_peaks
                falseP=falseP+1;
            else
                falseN=falseN+1;
            end
        end
    end
    trueP
    falseP
    falseN
    Precision=trueP/(trueP+falseP)
    Recall=trueP/(trueP+falseN)
    total_trueP=total_trueP+trueP;
    total_falseP=total_falseP+falseP;
    total_falseN=total_falseN+falseN;
    total_Precision=total_trueP/(total_trueP+total_falseP)
    total_Recall=total_trueP/(total_trueP+total_falseN)
    
end

