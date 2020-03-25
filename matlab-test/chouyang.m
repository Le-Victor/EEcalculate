%% 抽样函数
function [xitongxvlie]=chouyang(caiyangnianshu)
global extmpc;
%% 发电机故障参数赋值
fadianjicanshufuzhi=extmpc.gen(:,22:23);
%% 线路故障参数赋值
xianlucanshufuzhi=extmpc.branch(:,14:15);
%% 全系统故障参数赋值
xitongtingyun=extmpc.xitongtingyun;
%% 采样时间
caiyangshijian=caiyangnianshu*8760;
%% 采样
%% 生成发电机序列
fadianjixulie=[];
for i=1:extmpc.Ngen
    yihangxulie=[];
    j=0;
    while(j<=caiyangshijian)
        a=rand;
        t1=round(-log(a)/fadianjicanshufuzhi(i,1));
        yihangxulie=[yihangxulie zeros(1,t1)]; %正常运行时间段
        a=rand;
        t2=round(-log(a)/fadianjicanshufuzhi(i,2));
        yihangxulie=[yihangxulie ones(1,t2)];  %故障时间段
        j=j+t1+t2;
    end
    fadianjixulie=[fadianjixulie;yihangxulie(1,1:caiyangshijian)];
end
%G=find(fadianjixulie(1,:));%测试
%% 生成线路序列
xianluxulie=[];
for i=1:extmpc.NL
    yihangxulie=[];
    j=0;
    while(j<=caiyangshijian)
         a=rand;
        t1=round(-log(a)/xianlucanshufuzhi(i,1));
        yihangxulie=[yihangxulie,zeros(1,t1)]; %正常运行时间段 
        a=rand;
        t2=round(-log(a)/xianlucanshufuzhi(i,2));
        yihangxulie=[yihangxulie,ones(1,t2)];  %故障时间段     
        j=j+t1+t2;
    end
    xianluxulie=[xianluxulie;yihangxulie(1,1:caiyangshijian)];
end
%% 生成配电网序列
peidianwangxvlie=ones(extmpc.Nbus,caiyangshijian);
for i=1:extmpc.Nbus
    if extmpc.busstate(i).data(1,2)==1
        peidianwangxvlie(i,:)=ones(1,caiyangshijian);
    else
        yihangxulie=[];
        j=0;
        while(j<=caiyangshijian)
            a=rand;
            %第一列为累积概率,k从1开始，1为无故障
            klmat=find(extmpc.busstate(i).data(:,1)>a);
            k=klmat(end);
            t1=round(-log(a)/(1-extmpc.busstate(i).data(k,2)));%第二列为马尔科夫等效后状态概率%此行有问题
            yihangxulie=[yihangxulie,k*ones(1,t1)]; %配电系统该状态运行时间
            j=j+t1;
        end
        peidianwangxvlie(i,:)=yihangxulie(1,1:caiyangshijian);
    end
end
%% 生成整体性故障序列（海底管道、极端天气、控制系统故障）
yihangxulie=[];
j=0;
while(j<=caiyangshijian+10)
        a=rand;
    t2=round(-log(a)/xitongtingyun(2));
    yihangxulie=[yihangxulie,ones(1,t2)];  %故障时间段
    a=rand;
    t1=round(-log(a)/xitongtingyun(1));
    yihangxulie=[yihangxulie,zeros(1,t1)]; %正常运行时间段

    j=j+t1+t2;
end
try xitongtingyunguzhang=yihangxulie(1:caiyangshijian);
catch save yihangxulie;
end
%% 系统序列
xitongxvlie=[fadianjixulie;xianluxulie;peidianwangxvlie;xitongtingyunguzhang];
end