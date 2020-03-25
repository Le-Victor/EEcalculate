function res=errloss(mpc,c,frompoint,endpoint,NL)
%最小割集法枚举判断损失量
possiablePaths = findPath(c, frompoint, endpoint);
LMat=solveLMat(c,possiablePaths,NL);
Fault1=zeros(NL,10);
Fault1(:,1)=1:NL;
for num=1:NL
    if isempty(find(LMat(:,num)==0, 1))
        Fault1(num,4)=1;
        Fault1(num,5)=mpc.bus(endpoint,2)+mpc.bus(endpoint,3)*1i;
        Fault1(num,6)=mpc.bus(endpoint,4);
        Fault1(num,7:10)=mpc.bus(endpoint,7:10);
    end
end
faultcompany2=nchoosek(1:NL,2);
NF2=size(faultcompany2,1);
Fault2=zeros(NF2,10);
Fault2(:,1:2)=faultcompany2;
for num=1:NF2
    LMAT2=LMat(:,faultcompany2(num,1))+LMat(:,faultcompany2(num,2));
    if isempty(find(LMAT2==0, 1))
        Fault2(num,4)=1;
        Fault2(num,5)=mpc.bus(endpoint,2)+mpc.bus(endpoint,3)*1i;
        Fault2(num,6)=mpc.bus(endpoint,4);
        Fault2(num,7:10)=mpc.bus(endpoint,7:10);
    end
end
faultcompany3=nchoosek(1:NL,3);
NF2=size(faultcompany3,1);
Fault3=zeros(NF2,10);
Fault3(:,1:3)=faultcompany3;
for num=1:NF2
    LMAT2=LMat(:,faultcompany3(num,1))+LMat(:,faultcompany3(num,2))+LMat(:,faultcompany3(num,3));
    if isempty(find(LMAT2==0, 1))
        Fault3(num,4)=1;
        Fault3(num,5)=mpc.bus(endpoint,2)+mpc.bus(endpoint,3)*1i;
        Fault3(num,6)=mpc.bus(endpoint,4);
        Fault3(num,7:10)=mpc.bus(endpoint,7:10);
    end
end
res.Fault1=Fault1;
res.Fault2=Fault2;
res.Fault3=Fault3;

 res.Fault=[Fault1;Fault2;Fault3];
end