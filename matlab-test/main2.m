function calculate(file)
clc
global extmpc;
filepath=file;
extmpc=readdata(filepath);
[PLC,EENS,LOLF,EPAF,PAP,fangcha1,fangcha2,numcount,oilalltemp,stateMat]=shixumc(500,20);
xlswrite([filepath,'/result'],{'PLC'},1,'A1');
xlswrite([filepath,'/result'],PLC,1,'B1');
xlswrite([filepath,'/result'],{'EENS'},1,'A2');
xlswrite([filepath,'/result'],EENS,1,'B2');
xlswrite([filepath,'/result'],{'LOLF'},1,'A3');
xlswrite([filepath,'/result'],LOLF,1,'B3');
xlswrite([filepath,'/result'],{'EPAF'},1,'A4');
xlswrite([filepath,'/result'],EPAF,1,'B4');
xlswrite([filepath,'/result'],{'PAP'},1,'A5');
xlswrite([filepath,'/result'],PAP,1,'B5');
end

