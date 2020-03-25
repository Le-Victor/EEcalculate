function stateMat1=cutLoad(stateMat1)
global extmpc;
extmpctemp=extmpc;
cutload=0;
oilloss=0;
%% ������ȡ
stvari1=stateMat1(1:extmpc.Ngen);%�����
stvari2=stateMat1(extmpc.Ngen+1:extmpc.NL+extmpc.Ngen);%��·
stvari3=stateMat1(extmpc.NL+extmpc.Ngen+1:extmpc.NL+extmpc.Ngen+extmpc.Nbus);%�����
%% ȥ������Ԫ��
%% �����ѿ۹��ʱ�
Ncut=length(extmpctemp.busstate(1).data(1,:))-10;
cutpowerlist=zeros(extmpc.Nbus,Ncut+1);
%% �����������Ϣ���и���˳�����Ϣ
nload=size(extmpctemp.load,1);
for num=1:nload
    i=extmpctemp.load(num,1);
    k=stvari3(i);
    cutload=cutload+(extmpctemp.busstate(i).data(1,3)+extmpctemp.busstate(i).data(1,4)*1i-(extmpctemp.busstate(i).data(k,3)+extmpctemp.busstate(i).data(k,4)*1i))*extmpc.baseMVA;
    extmpctemp.bus(i,3:4)=extmpctemp.busstate(i).data(k,3:4);%���¹�����Ϣ
    extmpctemp.bus(i,20:21)=extmpctemp.busstate(i).data(k,5:6);%����������ʧ��Ϣ
    extmpctemp.load(num,7:8)=extmpctemp.busstate(i).data(k,7:8);%���±�����Ϲ�����Ϣ
    extmpctemp.load(num,16:17)=extmpctemp.busstate(i).data(k,9:10);%���¾�̬������Ϣ
    cutpowerlist(i,:)=[0,extmpctemp.busstate(i).data(k,11:end)];%���������ѿ۹��ʱ���Ϣ
    oilloss=oilloss+extmpctemp.busstate(i).data(1,5)-extmpctemp.busstate(i).data(k,5);
end
%% ���������ѿ۱���Ϣ
cutpowerlist(extmpc.Nbus+1,:)=sum(cutpowerlist(1:extmpc.Nbus,:));%�ܵ��и�������
%% ������·���������Ϣ
%��������·��mpc.branch���޳�
cl=0;%�г���·��
for numl=1:length(stvari2)
    if stvari2(numl)>0
        extmpctemp.branch(numl-cl,:)=[];
        cl=cl+1;
    end
end

%�����Ϸ������mpc.gen���޳�
cl=0;
for numg=1:length(stvari1)
    if stvari1(numg)>0
        extmpctemp.gen(numg-cl,:)=[];
        cl=cl+1;
    end
end
%% �ж�ϵͳ�Ƿ����
% �ж��Ƿ���ڹ����޵�Դĸ��
%% �жϹ���ĸ�����
mpcgroup = find_islands(extmpctemp);%����ƽ̨����
busall=1:extmpc.Nbus;
%���Ҳ��뷢���ĸ����ϵĸ��
for i=1:length(mpcgroup)
    busall=setdiff(busall, mpcgroup{1, i});
end
buscut=busall;%����ĸ����Ŀ

%% ��������ڵ��и���ָ��
if isempty(buscut)==0
    num=1;
    Nlimit=length(buscut);
    while num<=Nlimit
        %�ж���Ҫĸ���Ƿ񱻹�������ȫ��ϵͳ�и���
        if isempty(find(extmpctemp.importbus==buscut(num), 1))%���û����Ҫĸ�߱�����
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
%% ����ϵͳ�ж�
%% �жϽ������
extmpcnew = extract_islands(extmpctemp);%����ƽ̨���
cutloadn=0;
if length(mpcgroup)==1%δ����
    %�и���
    [k,cutloadn]=cutLoadsmallsystem(extmpcnew{1,1},cutpowerlist);
    %���������ʱ�����
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