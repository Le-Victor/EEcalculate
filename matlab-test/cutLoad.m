function stateMat1=cutLoad(stateMat1)
global extmpc;
extmpctemp=extmpc;
cutload=0;
oilloss=0;
%% 分类提取
stvari1=stateMat1(1:extmpc.Ngen);%发电机
stvari2=stateMat1(extmpc.Ngen+1:extmpc.NL+extmpc.Ngen);%线路
stvari3=stateMat1(extmpc.NL+extmpc.Ngen+1:extmpc.NL+extmpc.Ngen+extmpc.Nbus);%配电网
%% 去除故障元件
%% 优先脱扣功率表
Ncut=length(extmpctemp.busstate(1).data(1,:))-10;
cutpowerlist=zeros(extmpc.Nbus,Ncut+1);
%% 更新配电网信息及切负荷顺序表信息
nload=size(extmpctemp.load,1);
for num=1:nload
    i=extmpctemp.load(num,1);
    k=stvari3(i);
    cutload=cutload+(extmpctemp.busstate(i).data(1,3)+extmpctemp.busstate(i).data(1,4)*1i-(extmpctemp.busstate(i).data(k,3)+extmpctemp.busstate(i).data(k,4)*1i))*extmpc.baseMVA;
    extmpctemp.bus(i,3:4)=extmpctemp.busstate(i).data(k,3:4);%更新功率信息
    extmpctemp.bus(i,20:21)=extmpctemp.busstate(i).data(k,5:6);%更新生产损失信息
    extmpctemp.load(num,7:8)=extmpctemp.busstate(i).data(k,7:8);%更新泵类符合功率信息
    extmpctemp.load(num,16:17)=extmpctemp.busstate(i).data(k,9:10);%更新静态功率信息
    cutpowerlist(i,:)=[0,extmpctemp.busstate(i).data(k,11:end)];%更新优先脱扣功率表信息
    oilloss=oilloss+extmpctemp.busstate(i).data(1,5)-extmpctemp.busstate(i).data(k,5);
end
%% 更新优先脱扣表信息
cutpowerlist(extmpc.Nbus+1,:)=sum(cutpowerlist(1:extmpc.Nbus,:));%总的切负荷量表
%% 更新线路及发电机信息
%将故障线路从mpc.branch中剔除
cl=0;%切除线路数
for numl=1:length(stvari2)
    if stvari2(numl)>0
        extmpctemp.branch(numl-cl,:)=[];
        cl=cl+1;
    end
end

%将故障发电机从mpc.gen中剔除
cl=0;
for numg=1:length(stvari1)
    if stvari1(numg)>0
        extmpctemp.gen(numg-cl,:)=[];
        cl=cl+1;
    end
end
%% 判断系统是否解列
% 判断是否存在孤立无电源母线
%% 判断孤立母线情况
mpcgroup = find_islands(extmpctemp);%解列平台分组
busall=1:extmpc.Nbus;
%查找不与发电机母线联系母线
for i=1:length(mpcgroup)
    busall=setdiff(busall, mpcgroup{1, i});
end
buscut=busall;%孤立母线数目

%% 计算孤立节点切负荷指标
if isempty(buscut)==0
    num=1;
    Nlimit=length(buscut);
    while num<=Nlimit
        %判断重要母线是否被孤立导致全子系统切负荷
        if isempty(find(extmpctemp.importbus==buscut(num), 1))%如果没有重要母线被孤立
            cutload=cutload+(extmpctemp.bus(buscut(num),3)+extmpctemp.bus(buscut(num),4)*1i)*extmpc.baseMVA;
            oilloss=oilloss+extmpctemp.bus(buscut(num),20);
        else
            [row1,col1]=find(extmpctemp.oilsubgroup==buscut(num));
            [row2,col2]=find(extmpctemp.unimportbus(row1(1),:)>0);
            buscut=[buscut,extmpctemp.unimportbus(row1(1),col2)];
        end
        num=num+1;
        Nlimit=length(buscut);
    end
end
%% 分子系统判断
%% 判断解列情况
extmpcnew = extract_islands(extmpctemp);%解列平台组合
cutloadn=0;
if length(mpcgroup)==1%未解列
    %切负荷
    [k,cutloadn]=cutLoadsmallsystem(extmpcnew{1,1},cutpowerlist);
    %如果发生长时间故障
    if (k>extmpctemp.kstop)&&(stateMat1(end-4)==1)
        cutloadn=0;
        for num2=1:size(extmpcnew{1,1}.bus,1)
            oilloss=oilloss+extmpcnew{1,1}.bus(num2,20);
            cutloadn=cutloadn+(extmpcnew{1,1}.bus(num2,3)+extmpcnew{1,1}.bus(num2,4)*1i)*extmpc.baseMVA;
        end
    elseif (k>extmpctemp.klossset)
        for num2=1:size(extmpcnew{1,1}.bus,1)
            oilloss=oilloss+extmpcnew{1,1}.bus(num2,20);
        end
    end
else
    for num1=1:length(extmpcnew)
        if isempty(extmpcnew{1,num1}.gen)
            cutloadn(num1)=0;
            for num2=1:size(extmpcnew{1,num1}.bus,1)
                cutloadn(num1)=cutloadn(num1)+(extmpcnew{1,num1}.bus(num2,3)+extmpcnew{1,num1}.bus(num2,4)*1i)*extmpc.baseMVA;
                oilloss=oilloss+extmpcnew{1,num1}.bus(num2,20);
            end
        else
            [k(num1),cutloadn(num1)]=cutLoadsmallsystem(extmpcnew{1,num1},cutpowerlist);
            if (k(num1)>extmpctemp.kstop)&&(stateMat1(end-4)==1)
                cutloadn(num1)=0;
                for num2=1:size(extmpcnew{1,num1}.bus,1)
                    oilloss=oilloss+extmpcnew{1,num1}.bus(num2,20);
                    cutloadn(num1)=cutloadn(num1)+(extmpcnew{1,num1}.bus(num2,3)+extmpcnew{1,num1}.bus(num2,4)*1i)*extmpc.baseMVA;
                end
            elseif k(num1)>extmpctemp.klossset
                for num2=1:size(extmpcnew{1,num1}.bus,1)
                    oilloss=oilloss+extmpcnew{1,num1}.bus(num2,20);
                end
            end
        end
    end
end
cutload=(cutload+sum(cutloadn));
stateMat1(end-2)=cutload;
stateMat1(end-1)=oilloss;
stateMat1(end)=oilloss;
end