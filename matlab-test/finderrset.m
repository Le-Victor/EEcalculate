function errset=finderrset(res)
%找到故障集
errset=[];
%找到一阶故障集
x=find(res.Fault1(:,4)==1);
if isempty(x)==0
errset=[errset;res.Fault1(x,:)];
end
%找到二阶故障集
x=find(res.Fault2(:,4)==1);
if isempty(x)==0
errset=[errset;res.Fault2(x,:)];
end
%找到三阶割集
%找到一阶故障集
x=find(res.Fault3(:,4)==1);
if isempty(x)==0
errset=[errset;res.Fault3(x,:)];
end
end