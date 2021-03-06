beat_list={'.','N','R','A','a','J','S','V','F','e','j','E','/','f'};
s=length(beat_list);
h=[];
file_list={'mitdb/100','mitdb/101','mitdb/103','mitdb/105', ...
    'mitdb/106','mitdb/108','mitdb/109','mitdb/111','mitdb/112','mitdb/113','mitdb/114', ...
    'mitdb/115','mitdb/116','mitdb/117','mitdb/118','mitdb/119','mitdb/121','mitdb/122','mitdb/123', ...
    'mitdb/124','mitdb/200','mitdb/201','mitdb/202','mitdb/203','mitdb/205','mitdb/207','mitdb/208', ...
     'mitdb/209','mitdb/210','mitdb/201','mitdb/212','mitdb/213','mitdb/214','mitdb/215', ...
      'mitdb/219','mitdb/220','mitdb/221','mitdb/222','mitdb/223','mitdb/228','mitdb/230','mitdb/231', ...
       'mitdb/232','mitdb/233','mitdb/234'};
t=length(file_list);
for j=1:t
    name=file_list{j}
    [f,freq,tm]=rdsamp(name,[]);
    f=f(:,1)';
    n=length(f);
    g=PeakFilter(f,360);
    gmed=max([g;g([1,1:n-1]);g([2:n,n])]);
    [ann,anntype,subtype,chan,num,comments]=rdann(name,'atr');
    for i=1:s
        x=find(anntype==beat_list{i});
        h=[h,gmed(ann(x))];
 %       beat_list{i}
 %       ann(x(find(gmed(ann(x))<7)))
    end
end
h=sort(h);
plot(h);



