%% ��������
function [xitongxvlie]=chouyang(caiyangnianshu)
global extmpc;
%% ��������ϲ�����ֵ
fadianjicanshufuzhi=extmpc.gen(:,22:23);
%% ��·���ϲ�����ֵ
xianlucanshufuzhi=extmpc.branch(:,14:15);
%% ȫϵͳ���ϲ�����ֵ
xitongtingyun=extmpc.xitongtingyun;
%% ����ʱ��
caiyangshijian=caiyangnianshu*8760;
%% ����
%% ���ɷ��������
fadianjixulie=[];
for i=1:extmpc.Ngen
    yihangxulie=[];
    j=0;
    while(j<=caiyangshijian)
        a=rand;
        t1=round(-log(a)/fadianjicanshufuzhi(i,1));
        yihangxulie=[yihangxulie zeros(1,t1)]; %��������ʱ���
        a=rand;
        t2=round(-log(a)/fadianjicanshufuzhi(i,2));
        yihangxulie=[yihangxulie ones(1,t2)];  %����ʱ���
        j=j+t1+t2;
    end
    fadianjixulie=[fadianjixulie;yihangxulie(1,1:caiyangshijian)];
end
%G=find(fadianjixulie(1,:));%����
%% ������·����
xianluxulie=[];
for i=1:extmpc.NL
    yihangxulie=[];
    j=0;
    while(j<=caiyangshijian)
         a=rand;
        t1=round(-log(a)/xianlucanshufuzhi(i,1));
        yihangxulie=[yihangxulie,zeros(1,t1)]; %��������ʱ��� 
        a=rand;
        t2=round(-log(a)/xianlucanshufuzhi(i,2));
        yihangxulie=[yihangxulie,ones(1,t2)];  %����ʱ���     
        j=j+t1+t2;
    end
    xianluxulie=[xianluxulie;yihangxulie(1,1:caiyangshijian)];
end
%% �������������
peidianwangxvlie=ones(extmpc.Nbus,caiyangshijian);
for i=1:extmpc.Nbus
    if extmpc.busstate(i).data(1,2)==1
        peidianwangxvlie(i,:)=ones(1,caiyangshijian);
    else
        yihangxulie=[];
        j=0;
        while(j<=caiyangshijian)
            a=rand;
            %��һ��Ϊ�ۻ�����,k��1��ʼ��1Ϊ�޹���
            klmat=find(extmpc.busstate(i).data(:,1)>a);
            k=klmat(end);
            t1=round(-log(a)/(1-extmpc.busstate(i).data(k,2)));%�ڶ���Ϊ����Ʒ��Ч��״̬����%����������
            yihangxulie=[yihangxulie,k*ones(1,t1)]; %���ϵͳ��״̬����ʱ��
            j=j+t1;
        end
        peidianwangxvlie(i,:)=yihangxulie(1,1:caiyangshijian);
    end
end
%% ���������Թ������У����׹ܵ�����������������ϵͳ���ϣ�
yihangxulie=[];
j=0;
while(j<=caiyangshijian+10)
        a=rand;
    t2=round(-log(a)/xitongtingyun(2));
    yihangxulie=[yihangxulie,ones(1,t2)];  %����ʱ���
    a=rand;
    t1=round(-log(a)/xitongtingyun(1));
    yihangxulie=[yihangxulie,zeros(1,t1)]; %��������ʱ���

    j=j+t1+t2;
end
try xitongtingyunguzhang=yihangxulie(1:caiyangshijian);
catch save yihangxulie;
end
%% ϵͳ����
xitongxvlie=[fadianjixulie;xianluxulie;peidianwangxvlie;xitongtingyunguzhang];
end