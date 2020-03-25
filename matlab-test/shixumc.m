function [PLC,EENS,LOLF,EPAF,PAP,fangcha1,fangcha2,numcount,oilalltemp,stateMat]=shixumc(caiyangnianshu,Nmax)
%状态存储矩阵
global stateMat;
global extmpc;
stateMat=[];
%无故障状态
noerr=[zeros(extmpc.Ngen+extmpc.NL,1);ones(extmpc.Nbus,1);0;1;0;0;0;0];
%全系统故障
allerr=[zeros(extmpc.Ngen+extmpc.NL,1);ones(extmpc.Nbus,1);1;1;0;0;0;extmpc.alloilloss];
stateMat=[stateMat,noerr,allerr];
%年生产任务存储矩阵
global papmat;
papmat=[];
%% 全系统故障参数赋值
%当前次数
nownum=0;
%切负荷故障状态数
errnum=0;
%切负荷概率
LOLP=0;
%电量损失期望
EENS=0;
%切负荷故障频率
LOLF=0;
%石油损失
sumoilloss=0;
%因电力系统造成的石油损失年期望
EPAF=0;
%完成年生产任务的概率
PAP=0;
%% 抽样判断
numcount=0;
while numcount<=Nmax
    numcount=numcount+1;
    %% 抽样
    [xitongxvlie]=chouyang(caiyangnianshu);
    %% 判断
    [PLC,EENS,LOLF,EPAF,PAP,fangcha1,fangcha2,oilalltemp]=panduan(xitongxvlie,caiyangnianshu);
    if (fangcha1<1e-3)&&(fangcha2<1e-6)
        break
    end
end
PLC=PLC*8760;
EENS=real(EENS)*8760;
LOLF=LOLF*8760;
EPAF=EPAF*8760;
end
