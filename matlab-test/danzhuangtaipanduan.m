%单状态切负荷及原油损失计算
function [cutoil]=danzhuangtaipanduan(stateMat1)
global stateMat;
global extmpc;
global beforesumcutele;
global statechange;
%% 判断是否有故障
stvaritemp=stateMat1(1:extmpc.NL+extmpc.Ngen+extmpc.Nbus);
stvaritemp(extmpc.NL+extmpc.Ngen+1:extmpc.NL+extmpc.Ngen+extmpc.Nbus)=stateMat1(extmpc.NL+extmpc.Ngen+1:extmpc.NL+extmpc.Ngen+extmpc.Nbus)-1;
if(isempty(find(stvaritemp>0, 1)))
    stateMat(end-3,1)=stateMat(end-3,1)+stateMat1(end-3);
    cutoil=0;
    beforesumcutele=0;
    return
end
%% 是否有全系统故障
if stateMat1(extmpc.NL+extmpc.Ngen+extmpc.Nbus+1)==1
    stateMat(end-3,2)=stateMat(end-3,2)+stateMat1(end-3);
    cutoil=stateMat(end,2)*stateMat1(end-3);
    statechange=statechange+1;
    beforesumcutele=stateMat(end-2,2);
    return
end
%% 如果故障之前发生过
for num1=1:length(stateMat(1,:))
    if stateMat1(1:end-4)==stateMat(1:end-4,num1)
        stateMat(end-3,num1)=stateMat(end-3,num1)+stateMat1(end-3);
        cutoil=stateMat(end,num1)*stateMat1(end-3);
        if beforesumcutele<stateMat(end-2,num1)
            statechange=statechange+1;
        end
        beforesumcutele=stateMat(end-2,num1);
        return
    end
end
%% 新故障
stateMat1=cutLoad(stateMat1);
stateMat=[stateMat,stateMat1];
cutoil=stateMat1(end)*stateMat1(end-3);
if beforesumcutele<stateMat1(end-2)
    statechange=statechange+1;
end
beforesumcutele=stateMat1(end-2);
end
