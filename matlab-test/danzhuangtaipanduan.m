%��״̬�и��ɼ�ԭ����ʧ����
function [cutoil]=danzhuangtaipanduan(stateMat1)
global stateMat;
global extmpc;
global beforesumcutele;
global statechange;
%% �ж��Ƿ��й���
stvaritemp=stateMat1(1:extmpc.NL+extmpc.Ngen+extmpc.Nbus);
stvaritemp(extmpc.NL+extmpc.Ngen+1:extmpc.NL+extmpc.Ngen+extmpc.Nbus)=stateMat1(extmpc.NL+extmpc.Ngen+1:extmpc.NL+extmpc.Ngen+extmpc.Nbus)-1;
if(isempty(find(stvaritemp>0, 1)))
    stateMat(end-3,1)=stateMat(end-3,1)+stateMat1(end-3);
    cutoil=0;
    beforesumcutele=0;
    return
end
%% �Ƿ���ȫϵͳ����
if stateMat1(extmpc.NL+extmpc.Ngen+extmpc.Nbus+1)==1
    stateMat(end-3,2)=stateMat(end-3,2)+stateMat1(end-3);
    cutoil=stateMat(end,2)*stateMat1(end-3);
    statechange=statechange+1;
    beforesumcutele=stateMat(end-2,2);
    return
end
%% �������֮ǰ������
for num1=1:length(stateMat(1,:))
    if stateMat1(1:end-4)==stateMat(1:end-4,num1)
        stateMat(end-3,num1)=stateMat(end-3,num1)+stateMat1(end-3);
        cutoil=stateMat(end,num1)*stateMat1(end-3);
        if beforesumcutele<stateMat(end-2,num1)
            statechange=statechange+1;
        end
        beforesumcutele=stateMat(end-2,num1);
        return
    end
end
%% �¹���
stateMat1=cutLoad(stateMat1);
stateMat=[stateMat,stateMat1];
cutoil=stateMat1(end)*stateMat1(end-3);
if beforesumcutele<stateMat1(end-2)
    statechange=statechange+1;
end
beforesumcutele=stateMat1(end-2);
end
