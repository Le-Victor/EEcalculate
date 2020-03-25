function [extmpc]=readdata(filepath)
name1='main';
cunchuweizhi=[filepath,'/',name1];
a=xlsread(cunchuweizhi,'jssz');
extmpc.version=a(1);
extmpc.baseMVA=a(2);
extmpc.klossset=a(3);
extmpc.kstop=a(4);
extmpc.maxoillosslimit=a(5);
extmpc.bus=xlsread(cunchuweizhi,'bus');
extmpc.gen=xlsread(cunchuweizhi,'gen');
extmpc.branch=xlsread(cunchuweizhi,'branch');
extmpc.load=xlsread(cunchuweizhi,'load');
extmpc.gencost=xlsread(cunchuweizhi,'gencost');
extmpc.oilsubgroup=xlsread(cunchuweizhi,'ytq');
extmpc.importbus=xlsread(cunchuweizhi,'zymx');
extmpc.unimportbus=xlsread(cunchuweizhi,'fzymx');
extmpc.xitongtingyun=xlsread(cunchuweizhi,'xtgzxx');
lianluomuxiandata=[1,1,zeros(1,23)];
for num=1:length(extmpc.bus(:,1))
    if isempty(find(extmpc.load(:,1)==extmpc.bus(num,1), 1))
        extmpc.busstate(num).data=lianluomuxiandata;
    else
        name2=num2str(num);
        cunchuweizhi=[filepath,'/',name2];
        mpc.bus=xlsread(cunchuweizhi,'bus');
        a=xlsread(cunchuweizhi,'yx');
        mpc.youxiantuokou=a(1,:)+a(1,:)*1i;
        mpc.branch=xlsread(cunchuweizhi,'branch');
        mpc.load=xlsread(cunchuweizhi,'load');
        peidianyudubiao = formpeidianyundubiao(mpc);
        extmpc.busstate(num).data=peidianyudubiao;
    end
end
%% 导入数据电网数据
extmpc.NL=size(extmpc.branch,1);%线路数量
extmpc.Ngen=size(extmpc.gen,1);%发电机数量
extmpc.Nbus=size(extmpc.bus,1);%母线数据
% 总电量数据
extmpc.allload=sum(extmpc.bus(:,3))+sum(extmpc.bus(:,4))*1i;
% 总产油量数据
extmpc.alloilloss=sum(extmpc.bus(:,20));
end