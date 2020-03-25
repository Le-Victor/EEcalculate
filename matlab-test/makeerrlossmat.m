function errlossmat=makeerrlossmat(mpc)
%ƽ̨ȫ������
allpower=sum(mpc.bus(:,2)+mpc.bus(:,3)*1i);
%ȫ��������
alloilpro=sum(mpc.bus(:,4));
%�γ�����ͼ
c=makegraph(mpc);
%��·��Ŀ
NL=size(mpc.branch,1);
%% �ж�ĸ������
%��Ҫĸ�ߣ�Ҳ���ǿ��ܵ���ƽ̨ʧ���ĸ�ߣ���ҪΪ��ѹĸ�߼�Ӧ��ĸ��
Busimportant=find(mpc.bus(:,6)==1);
%����ĸ��
Buspro=find(mpc.bus(:,6)==0);
%% �ж��Ƿ�ᵼ��ȫƽ̨ʧ��
errset=[];
for num=1:length(Busimportant)
    res(num)=errloss(mpc,c,1,Busimportant(num),NL);
%     bus(num).errset=finderrset(res(num));
end
%% ��ͨ�и������ж�
for num=1:length(Buspro)
    res(num+length(Busimportant))=errloss(mpc,c,1,Buspro(num),NL);
end
%% ��ͣ�˱��γ�
Faultsystem=res(1).Fault;
for num=1:length(mpc.bus(:,6))
    Faultsystem(:,5:10)=Faultsystem(:,5:10)+res(num).Fault(:,5:10);
end
%��Ҫĸ��ʧ����ȫϵͳͣ��
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
%% �����״̬����
%����״̬����%1���� 2�������й� 3�������޹� 4ԭ�Ͳ��� 5��̬�й� 6��̬�޹� 7��̬�й� 8��̬�޹� 
%ȫƽ̨��õĸ���
perfectpossibility=1;
for num=1:length(mpc.branch(:,1))
    perfectpossibility=perfectpossibility*(1-mpc.branch(num,6));
end
%״̬���ʱ�
errlossmat(1,:)=[perfectpossibility,0,0,0];
numstate=2;
%�˴��ù�����Ϊ�ж�����Ϊ������С���㣬�Ҹ�ĸ�߹��ʲ�ͬ�����׳����غ�
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
                %��״̬������
                perrlossmatnumstate=perrlossmatnumstate*mpc.branch(Faultsystem(num,num2),6)/(1-mpc.branch(Faultsystem(num,num2),6));
            end     
        end
        errlossmat(x,1)=errlossmat(x,1)+perrlossmatnumstate;
    end
end
%????���ﻹ�����⣬Ϊʲô���ʻ��Դ���һ���Ǽ��㾫�ȵ�������
errlossmat(1,1)=1-sum(errlossmat(2:end,1));
%�γ�ʣ�๦�ʾ���
errlossmat(:,2)=real(allpower)-errlossmat(:,2);
errlossmat(:,3)=imag(allpower)-errlossmat(:,3);
errlossmat(:,4)=alloilpro-errlossmat(:,4);
errlossmat(:,5)=mpc.load(1,9)-errlossmat(:,5);
errlossmat(:,6)=mpc.load(1,10)-errlossmat(:,6);
errlossmat(:,7)=mpc.load(1,16)-errlossmat(:,7);
errlossmat(:,8)=mpc.load(1,17)-errlossmat(:,8);
end