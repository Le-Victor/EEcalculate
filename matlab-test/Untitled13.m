%% 判断是否有故障
stvaritemp=stateMat1(1:extmpc.NL+extmpc.Ngen+extmpc.Nbus);
stvaritemp(extmpc.NL+extmpc.Ngen+1:extmpc.NL+extmpc.Ngen+extmpc.Nbus)=stateMat1(extmpc.NL+extmpc.Ngen+1:extmpc.NL+extmpc.Ngen+extmpc.Nbus)-1;
if(isempty(find(stvaritemp>0, 1)))
    return
end
%% 是否有全系统故障
if stateMat1(extmpc.NL+extmpc.Ngen+extmpc.Nbus+1)==1
    stateMat1(end-2)=extmpc.allload;
    stateMat1(end-1)=0;
    stateMat1(end)=extmpc.alloilloss;
    return
end
%% 如果故障之前发生过
for num1=1:length(stateMat(1,:))
    if stateMat1(1:end-4)==stateMat(1:end-4,num1)
        stateMat1(end-2:end)=stateMat(end-2:end,num1);
        return
    end
end
%% 新故障
stateMat1=cutLoad(stateMat1);
i=3;
j=4;