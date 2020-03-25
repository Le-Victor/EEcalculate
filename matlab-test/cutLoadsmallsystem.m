function [k,cutload]=cutLoadsmallsystem(extmpctemp,cutpowerlist)
mpc.version = '2';
mpc.baseMVA = extmpctemp.baseMVA;
mpc.bus=extmpctemp.bus(:,1:13);
mpc.gen=extmpctemp.gen(:,1:21);
mpc.branch=extmpctemp.branch(:,1:13);
mpc.bus(:,3:4)=mpc.bus(:,3:4)*extmpctemp.baseMVA;
mpc.gen(:,2:5)=mpc.gen(:,2:5)*extmpctemp.baseMVA;
mpc.gen(:,9:10)=mpc.gen(:,9:10)*extmpctemp.baseMVA;
%形成小的子系统的数目表
nbus=size(extmpctemp.bus,1);
nload=size(find(extmpctemp.load(:,1)>0),1);
%默认切负荷等级为0
k=0;
%默认不切负荷
cutload=0;
%形成小的子系统的负荷表
i=1;
while i<=size(extmpctemp.load,1)
    if isempty(find(extmpctemp.bus(:,1)==extmpctemp.load(i,1),1))
        extmpctemp.load(i,:)=[];
    else
        i=i+1;
    end
end
%形成小系统的优先脱扣表
cutpowerlist2=[];
for i=1:nbus
    cutpowerlist2=[cutpowerlist2;cutpowerlist(extmpctemp.bus(i,1),:)];
end
cutpowerlist2(nbus+1,:)=sum(cutpowerlist2(1:nbus,:));%总的切负荷量表
%定性判断
sumload=sum(mpc.bus(:,3)+mpc.bus(:,4)*1i);%总负荷
sumgen=sum((mpc.gen(:,9)+mpc.gen(:,4)*1i).*mpc.gen(:,8));%发电机总发电量
if sumload>sumgen%如果发电机最大发电量不能满足需求
    %将冷备用发电机开启
    mpc.gen(:,8)=1;
    
    sumgen=sum((mpc.gen(:,9)+mpc.gen(:,4)*1i).*mpc.gen(:,8));
    if sumload>sumgen%如果发电机全部发起仍不能满足
        k=find(cutpowerlist(extmpctemp.Nbus+1,:)<sumgen,1);%判断切负荷到哪个等级
        for num=1:nload
            %应该用切符合后实际值，此处简化
            i=extmpctemp.load(num,1);
            try
            mpc.bus(i,3)=real(cutpowerlist2(i,k))*extmpctemp.baseMVA;
            mpc.bus(i,4)=imag(cutpowerlist2(i,k))*extmpctemp.baseMVA;
            cutload=sumload-(mpc.bus(i,3)+mpc.bus(i,4)*1i);
            catch save test
            end
        end
    end
end
res=runpf(mpc);
%迭代次数
irt=1;
%判断潮流是否成功
if res.success==0
    while (irt<=2)&&(res.success==0)&&(k<14)
        k=k+1;
        irt=irt+1;
        for num=1:nload
            %应该用切符合后实际值，此处简化
           i=extmpctemp.load(num,1);
            mpc.bus(i,3)=real(cutpowerlist2(i,k))*extmpctemp.baseMVA;
            mpc.bus(i,4)=imag(cutpowerlist2(i,k))*extmpctemp.baseMVA;
                   
        end
        res=runpf(mpc);
    end
end
cutload=sumload-sum(mpc.bus(:,3)+mpc.bus(:,4)*1i);   
if res.success==0
    cutload=sumload;
    k=15;
end
if abs(cutload)<1e-3
    cutload=0;
end
end