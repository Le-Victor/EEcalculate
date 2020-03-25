function errlossmat=makeerrlossmat(mpc)
%平台全部功率
allpower=sum(mpc.bus(:,2)+mpc.bus(:,3)*1i);
%全部产油量
alloilpro=sum(mpc.bus(:,4));
%形成连接图
c=makegraph(mpc);
%线路数目
NL=size(mpc.branch,1);
%% 判断母线类型
%重要母线，也就是可能导致平台失电的母线，主要为中压母线及应急母线
Busimportant=find(mpc.bus(:,6)==1);
%生产母线
Buspro=find(mpc.bus(:,6)==0);
%% 判断是否会导致全平台失电
errset=[];
for num=1:length(Busimportant)
    res(num)=errloss(mpc,c,1,Busimportant(num),NL);
%     bus(num).errset=finderrset(res(num));
end
%% 普通切负荷量判断
for num=1:length(Buspro)
    res(num+length(Busimportant))=errloss(mpc,c,1,Buspro(num),NL);
end
%% 总停运表形成
Faultsystem=res(1).Fault;
for num=1:length(mpc.bus(:,6))
    Faultsystem(:,5:10)=Faultsystem(:,5:10)+res(num).Fault(:,5:10);
end
%主要母线失负荷全系统停电
for num=1:length(Faultsystem(:,1))
    for num2=1:length(Busimportant)
        if res(num2).Fault(num,4)==1
            Faultsystem(num,5)=allpower;
            Faultsystem(num,6)=alloilpro;
            Faultsystem(num,4)=4;
            Faultsystem(num,7:8)=mpc.load(1,9:10);
            Faultsystem(num,9:10)=mpc.load(1,16:17);
        end
    end
end
%% 计算个状态概率
%概率状态矩阵%1概率 2负荷量有功 3负荷量无功 4原油产量 5动态有功 6动态无功 7静态有功 8静态无功 
%全平台完好的概率
perfectpossibility=1;
for num=1:length(mpc.branch(:,1))
    perfectpossibility=perfectpossibility*(1-mpc.branch(num,6));
end
%状态概率表
errlossmat(1,:)=[perfectpossibility,0,0,0];
numstate=2;
%此处用功率作为判断是因为功率有小数点，且各母线功率不同，不易出现重合
for num=1:length(Faultsystem(:,1))
    x=find(errlossmat(:,2)==real(Faultsystem(num,5)), 1);
    if isempty(x)
        for num2=1:3
            if Faultsystem(num,num2)>0
                errlossmat(numstate,1)=perfectpossibility*mpc.branch(Faultsystem(num,num2),6)/(1-mpc.branch(Faultsystem(num,num2),6));
                errlossmat(numstate,2)=real(Faultsystem(num,5));
                errlossmat(numstate,3)=imag(Faultsystem(num,5));
                errlossmat(numstate,4)=Faultsystem(num,6);
                errlossmat(numstate,5:8)=Faultsystem(num,7:10);
            end     
        end
        numstate=numstate+1;
    else
          perrlossmatnumstate=1;
        for num2=1:3
            if Faultsystem(num,num2)>0
                %该状态故障率
                perrlossmatnumstate=perrlossmatnumstate*mpc.branch(Faultsystem(num,num2),6)/(1-mpc.branch(Faultsystem(num,num2),6));
            end     
        end
        errlossmat(x,1)=errlossmat(x,1)+perrlossmatnumstate;
    end
end
%????这里还有问题，为什么概率会略大于一，是计算精度的问题吗？
errlossmat(1,1)=1-sum(errlossmat(2:end,1));
%形成剩余功率矩阵
errlossmat(:,2)=real(allpower)-errlossmat(:,2);
errlossmat(:,3)=imag(allpower)-errlossmat(:,3);
errlossmat(:,4)=alloilpro-errlossmat(:,4);
errlossmat(:,5)=mpc.load(1,9)-errlossmat(:,5);
errlossmat(:,6)=mpc.load(1,10)-errlossmat(:,6);
errlossmat(:,7)=mpc.load(1,16)-errlossmat(:,7);
errlossmat(:,8)=mpc.load(1,17)-errlossmat(:,8);
end