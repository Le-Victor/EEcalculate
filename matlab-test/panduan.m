%% 判断该序列可靠性结果
function [plctemp,eenstemp,lolftemp,epaftemp,paptemp,fangcha1,fangcha2,oilalltemp]=panduan(xitongxvlie,caiyangnianshu)
%% 方差判断年数
if caiyangnianshu>200%如果采样年数大于200年
    fangchapanduannian=100;%每100年判断方差是否已经收敛
else
    fangchapanduannian=floor(caiyangnianshu/2);
end
%% 状态存储
global extmpc;
%系统状态存储矩阵
global stateMat;
%年生产任务完成情况
global papmat;
%持续小时数
hourcon=1;
%跨年总小时数
hournewyear=1;
%长时间状态flag为1，短时间状态为0
flag=1;
%切负荷概率
plctemp=0;
%切负荷频率
lolftemp=0;
%电量不足期望
eenstemp=0;
%因电力系统造成的原油年减产量
epaftemp=0;
%原油年损失量
sumoillossyear=0;
oilalltemp=[];
%年是否完成生产任务矩阵
paptemp=0;
%切负荷量
global beforesumcutele;
beforesumcutele=0;
global statechange;
statechange=0;
for t1=1:floor(caiyangnianshu/fangchapanduannian)
    %每个状态
    t3=(t1-1)*fangchapanduannian*8760+1;
    while t3<t1*fangchapanduannian*8760      
            while xitongxvlie(:,t3)==xitongxvlie(:,t3+1)
               if t3<t1*fangchapanduannian*8760-1
                t3=t3+1;
               else
                   break
               end
                %%跨年事故记录两个状态
                if mod(t3,8760)==0
                    hourcon=hourcon+1;%单状态持续时间
                    hournewyear=hournewyear+1;%总年数持续时间
                    statetemp=[xitongxvlie(:,t3);1;hourcon;0;0;0];%倒数第五位为故障类型，倒数第四位为状态持续小时数，倒数第三为该状态每小时电量不足数，倒数第二为该状态每小时因电力系统原油切负荷数，倒数第一该状态每小时原油切负荷数
                    cutoil=danzhuangtaipanduan(statetemp);
                    hourcon=1;
                end
                hourcon=hourcon+1;
                hournewyear=hournewyear+1;
            end
        
        %% 判断事故是长时间事故还是短时事故
        if hournewyear>8
            flag=1;
        else
            flag=0;
        end
        %% 判断是否跨年
        if hournewyear>hourcon%如果跨年
            sumoillossyear=sumoillossyear+cutoil;
            %统计一年内数据
            if sumoillossyear>extmpc.maxoillosslimit
                papmat=[papmat,1];
                oilalltemp=[oilalltemp,sumoillossyear];
            else
                papmat=[papmat,0];
                oilalltemp=[oilalltemp,sumoillossyear];
            end
            %数据清零，开始新的一年
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
    %可靠性指标及方差计算
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