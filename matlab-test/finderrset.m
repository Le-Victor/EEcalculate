function errset=finderrset(res)
%�ҵ����ϼ�
errset=[];
%�ҵ�һ�׹��ϼ�
x=find(res.Fault1(:,4)==1);
if isempty(x)==0
errset=[errset;res.Fault1(x,:)];
end
%�ҵ����׹��ϼ�
x=find(res.Fault2(:,4)==1);
if isempty(x)==0
errset=[errset;res.Fault2(x,:)];
end
%�ҵ����׸
%�ҵ�һ�׹��ϼ�
x=find(res.Fault3(:,4)==1);
if isempty(x)==0
errset=[errset;res.Fault3(x,:)];
end
end