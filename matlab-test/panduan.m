%% �жϸ����пɿ��Խ��
function [plctemp,eenstemp,lolftemp,epaftemp,paptemp,fangcha1,fangcha2,oilalltemp]=panduan(xitongxvlie,caiyangnianshu)
%% �����ж�����
if caiyangnianshu>200%���������������200��
    fangchapanduannian=100;%ÿ100���жϷ����Ƿ��Ѿ�����
else
    fangchapanduannian=floor(caiyangnianshu/2);
end
%% ״̬�洢
global extmpc;
%ϵͳ״̬�洢����
global stateMat;
%����������������
global papmat;
%����Сʱ��
hourcon=1;
%������Сʱ��
hournewyear=1;
%��ʱ��״̬flagΪ1����ʱ��״̬Ϊ0
flag=1;
%�и��ɸ���
plctemp=0;
%�и���Ƶ��
lolftemp=0;
%������������
eenstemp=0;
%�����ϵͳ��ɵ�ԭ���������
epaftemp=0;
%ԭ������ʧ��
sumoillossyear=0;
oilalltemp=[];
%���Ƿ���������������
paptemp=0;
%�и�����
global beforesumcutele;
beforesumcutele=0;
global statechange;
statechange=0;
for t1=1:floor(caiyangnianshu/fangchapanduannian)
    %ÿ��״̬
    t3=(t1-1)*fangchapanduannian*8760+1;
    while t3<t1*fangchapanduannian*8760      
            while xitongxvlie(:,t3)==xitongxvlie(:,t3+1)
               if t3<t1*fangchapanduannian*8760-1
                t3=t3+1;
               else
                   break
               end
                %%�����¹ʼ�¼����״̬
                if mod(t3,8760)==0
                    hourcon=hourcon+1;%��״̬����ʱ��
                    hournewyear=hournewyear+1;%����������ʱ��
                    statetemp=[xitongxvlie(:,t3);1;hourcon;0;0;0];%��������λΪ�������ͣ���������λΪ״̬����Сʱ������������Ϊ��״̬ÿСʱ�����������������ڶ�Ϊ��״̬ÿСʱ�����ϵͳԭ���и�������������һ��״̬ÿСʱԭ���и�����
                    cutoil=danzhuangtaipanduan(statetemp);
                    hourcon=1;
                end
                hourcon=hourcon+1;
                hournewyear=hournewyear+1;
            end
        
        %% �ж��¹��ǳ�ʱ���¹ʻ��Ƕ�ʱ�¹�
        if hournewyear>8
            flag=1;
        else
            flag=0;
        end
        %% �ж��Ƿ����
        if hournewyear>hourcon%�������
            sumoillossyear=sumoillossyear+cutoil;
            %ͳ��һ��������
            if sumoillossyear>extmpc.maxoillosslimit
                papmat=[papmat,1];
                oilalltemp=[oilalltemp,sumoillossyear];
            else
                papmat=[papmat,0];
                oilalltemp=[oilalltemp,sumoillossyear];
            end
            %�������㣬��ʼ�µ�һ��
            sumoillossyear=0;
            statetemp=[xitongxvlie(:,t3-1);flag;hourcon;0;0;0];
            cutoil=danzhuangtaipanduan(statetemp);    
            sumoillossyear=sumoillossyear+cutoil;
        else
            statetemp=[xitongxvlie(:,t3-1);flag;hourcon;0;0;0];
            cutoil=danzhuangtaipanduan(statetemp);
            sumoillossyear=sumoillossyear+cutoil;
        end
        hourcon=1;
        hournewyear=1;
        t3=t3+1;
    end
    %�ɿ���ָ�꼰�������
    time=sum(stateMat(end-3,:));
    lolftemp=statechange/time;
    eenstemp=sum(stateMat(end-2,:).*stateMat(end-3,:))/time;
    epaftemp=sum(stateMat(end-1,:).*stateMat(end-3,:))/time;
    st=0;
    for num=1:length(stateMat(1,:))
        if stateMat(end-2,num)>0
            st=st+stateMat(end-3,num);
        end
    end
    plctemp=st/time;
    paptemp=mean(papmat);
    fangcha1=std(papmat)/sqrt(length(papmat));
    fangcha2=sqrt(1/(time-1)*(sum(stateMat(end-2,:).^2)-time*eenstemp^2))/sqrt(time);
    if (fangcha1<1e-3)&&(fangcha2<1e-6)
        return
    end
end
end