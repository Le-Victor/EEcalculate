function [PLC,EENS,LOLF,EPAF,PAP,fangcha1,fangcha2,numcount,oilalltemp,stateMat]=shixumc(caiyangnianshu,Nmax)
%״̬�洢����
global stateMat;
global extmpc;
stateMat=[];
%�޹���״̬
noerr=[zeros(extmpc.Ngen+extmpc.NL,1);ones(extmpc.Nbus,1);0;1;0;0;0;0];
%ȫϵͳ����
allerr=[zeros(extmpc.Ngen+extmpc.NL,1);ones(extmpc.Nbus,1);1;1;0;0;0;extmpc.alloilloss];
stateMat=[stateMat,noerr,allerr];
%����������洢����
global papmat;
papmat=[];
%% ȫϵͳ���ϲ�����ֵ
%��ǰ����
nownum=0;
%�и��ɹ���״̬��
errnum=0;
%�и��ɸ���
LOLP=0;
%������ʧ����
EENS=0;
%�и��ɹ���Ƶ��
LOLF=0;
%ʯ����ʧ
sumoilloss=0;
%�����ϵͳ��ɵ�ʯ����ʧ������
EPAF=0;
%�������������ĸ���
PAP=0;
%% �����ж�
numcount=0;
while numcount<=Nmax
    numcount=numcount+1;
    %% ����
    [xitongxvlie]=chouyang(caiyangnianshu);
    %% �ж�
    [PLC,EENS,LOLF,EPAF,PAP,fangcha1,fangcha2,oilalltemp]=panduan(xitongxvlie,caiyangnianshu);
    if (fangcha1<1e-3)&&(fangcha2<1e-6)
        break
    end
end
PLC=PLC*8760;
EENS=real(EENS)*8760;
LOLF=LOLF*8760;
EPAF=EPAF*8760;
end
